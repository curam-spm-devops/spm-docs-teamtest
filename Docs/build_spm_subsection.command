#!/bin/bash
# Bash script to run DITA-OT transforms

NAV_MAP="/Users/asohor/Github/spm-doc-from800/WATSONHEALTH/SPM/800/spm_navigation_sample.ditamap"
PRODOVERVIEW_MAP="/Users/asohor/Github/spm-doc-from800/WATSONHEALTH/SPM/800/spm_prod_overview_toc.ditamap"
DEPLOYWLS_MAP="/Users/asohor/Github/spm-doc-from800/WATSONHEALTH/SPM/800/CuramDeploymentGuideForWeblogicServer_toc.ditamap"
DEPLOYWAS_MAP="/Users/asohor/Github/spm-doc-from800/WATSONHEALTH/SPM/800/CuramDeploymentGuideForWebsphereApplicationServer_toc.ditamap"
DEPLOYWASZOS_MAP="/Users/asohor/Github/spm-doc-from800/WATSONHEALTH/SPM/800/CuramDeploymentGuideForWebsphereApplicationServerOnZOS_toc.ditamap"
TEST_FILTER="/Users/asohor/Github/spm-doc-from800/WATSONHEALTH/SPM/800/cur_spm_test.ditaval"
VERSION_FILTER="/Users/asohor/Github/spm-doc-from800/WATSONHEALTH/SPM/800/cur_spm802.ditaval"
BASE_FILTER="/Users/asohor/Github/spm-doc-from800/WATSONHEALTH/SPM/800/cur_base_spm800.ditaval"
OUTDIR="/Users/asohor/Documents/DITA-OT_output/SPM_HTML5"
CSSROOT="/Applications/dita-ot-4.0/docsrc/resources"
DEBUGLOG="/Users/asohor/Documents/DITA-OT_output/SPM_HTML5/logs/transform.log"

dita --input="$NAV_MAP" --format=html5 --output="$OUTDIR" --filter="$TEST_FILTER:$VERSION_FILTER:$BASE_FILTER" --args.html5.toc="spm_navigation_sample" --nav-toc=full --args.cssroot="$CSSROOT" --args.css=dita-ot-doc.css --args.copycss=yes --debug="$DEBUGLOG"

dita --input="$PRODOVERVIEW_MAP" --format=html5 --output="$OUTDIR" --filter="$TEST_FILTER:$VERSION_FILTER:$BASE_FILTER" --args.html5.toc="spm_prod_overview_toc" --nav-toc=full --args.cssroot="$CSSROOT" --args.css=dita-ot-doc.css --args.copycss=yes --debug="$DEBUGLOG"

dita --input="$DEPLOYWLS_MAP" --format=html5 --output="$OUTDIR" --filter="$TEST_FILTER:$VERSION_FILTER:$BASE_FILTER" --args.html5.toc="CuramDeploymentGuideForWeblogicServer_toc" --nav-toc=full --args.cssroot="$CSSROOT" --args.css=dita-ot-doc.css --args.copycss=yes --debug="$DEBUGLOG"

dita --input="$DEPLOYWASZOS_MAP" --format=html5 --output="$OUTDIR" --filter="$TEST_FILTER:$VERSION_FILTER:$BASE_FILTER" --args.html5.toc="CuramDeploymentGuideForWebsphereApplicationServerOnZOS_toc.ditamap" --nav-toc=full --args.cssroot="$CSSROOT" --args.css=dita-ot-doc.css --args.copycss=yes --debug="$DEBUGLOG"

dita --input="$DEPLOYWAS_MAP" --format=html5 --output="$OUTDIR" --filter="$TEST_FILTER:$VERSION_FILTER:$BASE_FILTER" --args.html5.toc="CuramDeploymentGuideForWebsphereApplicationServer_toc" --nav-toc=full --args.cssroot="$CSSROOT" --args.css=dita-ot-doc.css --args.copycss=yes --debug="$DEBUGLOG"

exit;
