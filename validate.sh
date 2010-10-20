#!/bin/sh

libDir=.

clear
echo Usage: build $1 = iso schematron file, no extension. $2 is the input xml file, with extension.
echo E.g. build input input.xml will produce input.report.xml as output

if [ $# -ne 2 ]
   then
   echo "Usage: build <filename>.sch <filename.ext> to use filename.sch to validate filename.ext"
   exit 2
fi

if [ -f $1.sch ]
   then
     echo
   else
     echo Schema file $1 not found
     exit 2
fi

if [ -e $2 ]
   then
   echo
   else
     echo input file $2 not found
     exit 2
fi



if [ -e tmp.xsl  ]
  then
    rm -f tmp.xsl
fi

if [ -e $1.report.xml ]
   then
    rm $1.report.xml
fi

echo Generate the stylesheet from $1

java  -mx250m -ms250m  -cp .:$libDir/saxon8.jar:$libDir/xercesImpl.jar \
       net.sf.saxon.Transform    -x org.apache.xerces.parsers.SAXParser -w1   \
       -o tmp.xsl    $1.sch schematron/iso_svrl_for_xslt2.xsl "generate-paths=yes"

# Add source document paths with the parameter "generate-paths=yes"

if [ $? -eq 0 ]
  then 
  echo run the input file $2 against the generated stylesheet $1.xsl to produce $1.report.xml

java  -mx250m -ms250m  -cp .:$libDir/saxon8.jar:$libDir/xercesImpl.jar \
    net.sf.saxon.Transform    -x org.apache.xerces.parsers.SAXParser -w1 -o $1.report.xml $2 tmp.xsl


fi
echo Done
