xhost +local:docker

cd ros1-vinsmono
docker build -t ros:vins-mono-local .
cd ..

cd ros2-readbags
docker build -t ros:jazzy-read-catacombs . 
cd ..

# docker compose up