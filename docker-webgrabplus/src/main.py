import xml.etree.ElementTree as ET
from datetime import datetime
import argparse
import re
import json

def writeXMLTV(tree, filename_output):
    tree.write(filename_output, encoding="UTF-8", xml_declaration=True, method="xml")

    return

def programme(program, min_treshold_minutes, max_treshold_minutes, do_categories_mapping, dict_categories):
   
    # Check if we need to do categories mapping
    if do_categories_mapping:
        # First handle the categories mapping as this is indepedent from the rest
   
        for category in program.findall('category'):
            # Check if category is in our predefined mapped list
            if category.text not in dict_categories.keys():
                # Warn the user that this category is not existing in the predefined mapped list
                print("Warning: Category '%s' not in predefined category mapping list. You might want to add it." % category.text)
                continue

            if not dict_categories[category.text]:
                # Category exists in predefined mapped list, but is mapped to empty string so do nothing
                continue

            # We have a mapping category; append that category
            new_category = ET.Element("category")
            new_category.set("lang", "us")
            new_category.text = dict_categories[category.text]
            program.append(new_category)

    # For programs that don't have episode-num tag; add tag if length of program is shorter than MOVIE_MINUTES_TRESHOLD.
    # This way plex will only categorize programs with longer length as movies
    
    element =  program.find('episode-num')
    if element is not None:
        #print ("episode-num already there")
        # Make sure episode-num contains a real season episode structure, which is S with number with space with E with number
        # S with just number and E with just number is ignored by plex and categorized as a movie
        episode = element.text
        if re.match(r"S\d E\d", episode):
            return
        if re.match(r"E\d", episode):
            # Prepend generated season based on start attribute
            start = program.attrib["start"]
            element.text = "S{} {}".format(start[2:4], episode)
            return

        if re.match(r"S\d", episode):
            # Append generated episode based on start attribute
            start = program.attrib["start"]
            element.text = "{} E{}".format(episode, start[5:8])
            return
 
        # No regexp matches; lets generate a season and episode nymber 

        # Start attribute looks like 20210125173000 +0000
        # Let's turn it into a season (year) and a episode number (month/day)
        start = program.attrib["start"]
        element.text = "S{} E{}".format(start[2:4], start[5:8])
            
        return

    # No episode-num, so now check length
    str_start = program.attrib['start']
    str_stop = program.attrib['stop']

    date_start = datetime.strptime(str_start, '%Y%m%d%H%M%S %z')
    date_stop = datetime.strptime(str_stop, '%Y%m%d%H%M%S %z')

    # Check if time difference is bigger than MOVIE_MINUTES_TRESHOLD
    diff = date_stop - date_start
    diff_seconds = diff.total_seconds()
    diff_minutes = diff_seconds/60
    if (diff_minutes > min_treshold_minutes) and (diff_minutes < max_treshold_minutes):
        #print("Probably a movie")
        return

    # So we have most probably a series (or news or documentary or ...) so add episode-num with airdate
    #print('Minutes: %3d' % diff_minutes)
    #print(tree.find('title').text)
    
    # Example tag <episode-num system="original-air-date">2018-07-27 09:30:00</episode-num>
    element_episode = ET.Element("episode-num")
    element_episode.set("system", "original-air-date")
    element_episode.text = datetime.strftime(date_start, '%Y-%m-%d %H:%M:%S')
    program.append(element_episode)
    
    return

def categories(program, dict_categories):

    # Get unique list of categories so that we can map them later on to one of the plex categories
    for category in program.findall('category'):
        #list_categories.append(category.text)
        dict_categories[category.text] = 'news'

    return


def readMappingCategories(dict_categories, filename_dict_categories):
    with open(filename_dict_categories, 'r') as json_file:
        dict_categories = json.load(json_file)

    return


def main():
    parser = argparse.ArgumentParser(description='Parses XMLTV for WebGrabPlus and reformats to be more plex friendly for movies.')
    parser.add_argument('-i', action="store", dest="filename_input", required=True, help='input file to parse')
    parser.add_argument('-o', action="store", dest="filename_output", required=True, help='output file that will be generated')
    parser.add_argument('-m', action="store", dest="min_treshold_minutes", required=False, type=int, default=80, help="Minimum treshold for minutes length that categorizes a movie")
    parser.add_argument('-M', action="store", dest="max_treshold_minutes", required=False, type=int, default=240, help="Maximum treshold for minutes length that categorizes a movie")
    parser.add_argument('-c', action="store", dest="filename_dict_categories", required=False, type=str, help="Categories list with hints to add either news, kids, series, sports additional category")
    args = parser.parse_args()

    print("Starting parsing of %s" % args.filename_input)
    
    tree = ET.parse(args.filename_input)
    root = tree.getroot()

    # Read the category mapping file if passed with arguments
    dict_categories = {}
    do_categories_mapping = False
    if args.filename_dict_categories is not None:
        with open(args.filename_dict_categories, 'r') as json_file:
            dict_categories = json.load(json_file)
        do_categories_mapping = True

    for child in root:
        if child.tag == 'programme':
            # Make it plex friendly
            programme(child, args.min_treshold_minutes, args.max_treshold_minutes, do_categories_mapping, dict_categories)

    writeXMLTV(tree, args.filename_output)

    print("Plex friendly generation done to file %s" % args.filename_output)

    return
            
if __name__ == "__main__":
    main()
