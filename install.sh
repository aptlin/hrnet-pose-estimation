# Copyright (c) 2020 Sasha Illarionov
# 
# This software is released under the MIT License.
# https://opensource.org/licenses/MIT

# ============================================================================== 
# The script installs the dependencies and downloads the weights 
# for the `pose_hrnet_w48` model trained on COCO
# ============================================================================== 

set -e

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
COCOAPI=$DIR/cocoapi
WEIGHTS=$DIR/scratchpad/weights

poetry install
cd $DIR/lib && make

cd $DIR 
[[ -d $COCOAPI ]] || (git clone https://github.com/cocodataset/cocoapi.git $COCOAPI && cd $COCOAPI/PythonAPI && python3 setup.py install --user)

cd $DIR && mkdir -p $WEIGHTS && cd $WEIGHTS

[[ -f pose_hrnet_w48_384x288.pth ]] || wget -O pose_hrnet_w48_384x288.pth https://www.dropbox.com/s/nxbkajwwzptxwp2/pose_hrnet_w48_384x288.pth?raw=1

cd $DIR