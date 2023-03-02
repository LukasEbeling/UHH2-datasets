#!/bin/bash

#README:
#First, split files using script below (fiel should not be larger than 3*2500 lines).
#Number of events and event weights are also counted.
#Second, write event weights into CrossSectionHelper.
#Third, adjust file names in 2HDM/config/config_generator/param_files_inv/uhh_samples_mc.yaml.

path=/nfs/dust/cms/user/ebelingl/uhh2_106X_v2/CMSSW_10_6_28/src/UHH2/common/UHH2-datasets/RunII_106X_v2/SM/UL17/
origin=TTToHadronic_CP5_powheg-pythia8_Summer20UL17_v2.xml

cd $path
split --lines=1000 $origin splitted

files=$(ls|grep "splitted")
num=1

cd $CMSSW_BASE/src/UHH2/scripts/crab
for file in $files
do
    name=TTToHadronic_CP5_powheg-pythia8_Summer20UL17_v2_$num.xml
    mv $path$file $path$name
    num=$((1 + num))
    python readaMCatNloEntries.py 10 $path$name True
    python readaMCatNloEntries.py 10 $path$name False
done

cd /nfs/dust/cms/user/ebelingl/uhh2_106X_v2/CMSSW_10_6_28/src/UHH2/common/UHH2-datasets




