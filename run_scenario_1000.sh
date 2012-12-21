#!/bin/bash

set -e

SCRIPTS_PATH=$PWD/scripts
export PATH=$PATH:$SCRIPTS_PATH
export PYTHONPATH=$PYTHONPATH:$PWD/../mainbranch

#DAS4 Set up:
module load prun/default


#rsync -a --delete ~/scenario_1000/ /var/scratch/emilon/scenario_1000/

#cd /var/scratch/emilon
#if [ ! -e experiments ]; then   
#   git clone git://paella.das2.ewi.tudelft.nl/git/dispersy_experiments.git #experiments
#else
#   cd experiments 
#   git pull
#   cd ..
#fi

cd ..

rm -fR dispersy_experiments/scenario_1000/output/*
rm -fR output/*

#echo "paella.das2.ewi.tudelft.nl 6421" > dispersy_experiments/scenario_1000/bootstraptribler.txt

cd mainbranch

das4-start $SCRIPTS_PATH/das4-allchannel.conf $PWD/../dispersy_experiments/scenario_1000/ 20 5 $HEAD_IP $TRACKER_PORT $SYNC_PORT
post-process-experiment $SCRIPTS_PATH/das4-allchannel.conf $PWD/../dispersy_experiments/scenario_1000/

cd ..

WORKSPACE=$PWD

cd dispersy_experiments/scenario_1000/output

R --no-save --quiet < $WORKSPACE/dispersy_experiments/scripts/r/drop.r
R --no-save --quiet < $WORKSPACE/dispersy_experiments/scripts/r/total_records.r
R --no-save --quiet < $WORKSPACE/dispersy_experiments/scripts/r/connections.r
R --no-save --quiet < $WORKSPACE/dispersy_experiments/scripts/r/send_received.r
R --no-save --quiet < $WORKSPACE/dispersy_experiments/scripts/r/cputimes.r

find -type f -exec chmod a+r {} \;
find -type d -exec chmod a+rx {} \;

#for FILE in records-dropped  records-received \
#            records-total statistics traffic-received\
#            traffic-sent connections-total-1 connections-total-2; do
#    convert -density 500 -resize 800x600 $FILE.eps $FILE.png
#done

#rsync -a --delete  ./ $WORKSPACE/output/

