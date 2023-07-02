fileName="test_clip1.mp4"
name="clipconverter-converter"
localClipsPath=""
localConvertedPath="clipconverter-converter"

# Clean up
docker rm "${name}"
docker image rm "${name}"

# Build and run
docker build -t "${name}" .
docker run \
    -it \
    --name "${name}" \
    -v "${localClipsPath}:/clips" \
    -v "${localConvertedPath}:/converted"\
    "${name}" \
    ./clipconverter-converter.sh \
    $fileName