#!/bin/zsh
#
# This script will kick off the CSV importer on the command line, using Docker run.
# It will launch a web server on port 8081 that you can approach and use to import data.

#
# Create a personal access token in your Firefly III installation, under 'Profile'
#
PERSONAL_ACCESS_TOKEN=eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9.eyJhdWQiOiIxMTAiLCJqdGkiOiIxY2I0MjYxYWY2OGU0OTZhYjYyNTdlM2I3M2VlZmNlYmI2YWY5MjExODlhZTZlYjI3MjBmNzdiNjJkYTQxYmYzOGEzYjk3MDM3YWQ5MWNkZSIsImlhdCI6MTU4OTEzMjQ4NCwibmJmIjoxNTg5MTMyNDg0LCJleHAiOjE2MjA2Njg0ODMsInN1YiI6IjEiLCJzY29wZXMiOltdfQ.mRAfaXQKIF-NJw0lAmMCxO_tz16UQBXoruQnLuYckCuMvN4HcRrSFkiH2d_5cv5-Cbi1Te8Gg1zQaLdSOikbOBT7GYekh1Ytv--woA202Rd78oo7L4sCPv_CRC5zp9VojN3z3Knc8AJCSNU_Mkt_oQ5acbvxLqH8FsHxU3TCPCT7Z_-tYlCVhOCYfH4cYOtgw4hihBnjNmY7ba1HENaGOCQje7_IXzXhMUPTBi9cntaNmfZgtyK5AFwJD1qbJSKJWlPWTsitBxszdqLA4d0y5FvKfGfEQBhKvYXUzyKZWcZtIluvAAMvKZVZssx8PcZOnqByI0nxSubFWjkZWiDuzINgTWOAVkI149kAE2ObnXH-jpdcyseLXW9n88rQP-_RRHaI0Pnm1GaCzKTjz_v3QAM89SGzPCt5CiYlWQdxqhwGY0V7cly1S7mkHRUcMDN_lVY9OdSaA9sS4ghnvyUv6Md-ICazPK1VvMtTHBCne-vwU72UGAZo1VKHaS68amfZNDidYOjAXLlX_R2MCJHdO-fNvNi4Fa5FAmGPrAHoJu63w4LgGKA_JTyTGg9MhHTbfk1y_PtzgShtP1IUcSl6TWlmuxrj5w8dSBUtQwkmkPqypLI8zm5MkrHe4cwtLwKQp2CvuIqhMtPoxusEqAfKPawzHLkOkWcHlPi_Zx8S0oQ

#
# This is the full path to your Firefly III installation:
#
FIREFLY_III_URI=http://firefly.aelvoetnet.be

#
# There is no need to touch anything after this point, but if you're smart you're free to do so.
#

docker run \
--rm \
-e FIREFLY_III_ACCESS_TOKEN=$PERSONAL_ACCESS_TOKEN \
-e FIREFLY_III_URI=$FIREFLY_III_URI \
-p 8083:80 \
fireflyiii/csv-importer:develop
