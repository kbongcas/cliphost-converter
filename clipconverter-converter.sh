#!/bin/bash
clipDir='clips'
convertedDir='converted'
fileName=$1
fileNameNoExt=${fileName%.mp4}
fileOutputName="${fileNameNoExt}.gif"
sa=$STORAGE_ACCOUNT
token=$TOKEN1
sa2=$STORAGE_ACCOUNT2
token2=$TOKEN2

echo "Pulling ${fileName} from blob storage..."

curl \
    -H "x-ms-version: 2019-12-12" \
    "https://${sa}.blob.core.windows.net/${clipDir}/${fileName}?${token}" \
    -o "/${clipDir}/${fileName}"

echo "Converting ${fileName} to ${fileOutputName}..."

ffmpeg \
    -i "/${clipDir}/${fileName}" -vf \
    'fps=30,scale=600:-1:flags=lanczos,split[s0][s1];[s0]palettegen=max_colors=64:reserve_transparent=0[p];[s1][p]paletteuse' \
    -y "/${convertedDir}/${fileOutputName}"

echo "Uploading ${fileOutputName} to blob storage..."

curl \
    -H "x-ms-blob-type: BlockBlob" \
    --upload-file "/${convertedDir}/${fileOutputName}" \
    --url "https://${sa}.blob.core.windows.net/${convertedDir}/${fileOutputName}?${token2}"

echo "Done.Exiting.."