import xml.etree.ElementTree as ET
from datetime import datetime
import argparse

#MOVIE_MINUTES_TRESHOLD = 80
#FILENAME_INPUT = "guide.xml"
#FILENAME_OUTPUT = "guide_plex.xml"

def writeXMLTV(tree, filename_output):
    tree.write(filename_output, encoding="UTF-8", xml_declaration=True, method="xml")

    return

def programme(program, treshold_minutes):
    #print(tree.tag, tree.attrib)

    # For programs that don't have episode-num tag; add tag if length of program is shorter than MOVIE_MINUTES_TRESHOLD.
    # This way plex will only categorize programs with longer length as movies
    
    element =  program.find('episode-num')
    if element is not None:
        #print ("episode-num already there")
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
    if diff_minutes > treshold_minutes:
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

def main():
    parser = argparse.ArgumentParser(description='Parses XMLTV for WebGrabPlus and reformats to be more plex friendly for movies.')
    parser.add_argument('-i', action="store", dest="filename_input", required=True, help='input file to parse')
    parser.add_argument('-o', action="store", dest="filename_output", required=True, help='output file that will be generated')
    parser.add_argument('-m', action="store", dest="treshold_minutes", required=True, type=int, help="Treshold for minutes length that categorizes a movie")

    args = parser.parse_args()

    print("Starting parsing of %s" % args.filename_input)
    
    tree = ET.parse(args.filename_input)
    root = tree.getroot()

    for child in root:
        #print(child.tag, child.attrib)
        if child.tag == 'programme':
            programme(child, args.treshold_minutes)
            #print(ET.tostring(child, encoding='utf8', method='xml'))

    writeXMLTV(tree, args.filename_output)

    print("Plex friendly generation done to file %s" % args.filename_output)

    return
            
if __name__ == "__main__":
    main()
