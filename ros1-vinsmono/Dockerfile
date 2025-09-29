FROM ros:kinetic-perception

ENV CERES_VERSION="1.12.0"
ENV CATKIN_WS=/root/catkin_ws


RUN   apt-get update && apt-get install -y \
      ros-${ROS_DISTRO}-rqt \
      ros-${ROS_DISTRO}-rqt-common-plugins \
      ros-${ROS_DISTRO}-turtlesim \
      ros-${ROS_DISTRO}-cv-bridge \
      ros-${ROS_DISTRO}-image-transport \
      ros-${ROS_DISTRO}-message-filters \
      ros-${ROS_DISTRO}-rviz \
      ros-${ROS_DISTRO}-tf && \
      rm -rf /var/lib/apt/lists/*

RUN   apt-get update && apt-get install -y \
      cmake \
      libatlas-base-dev \
      libeigen3-dev \
      libgoogle-glog-dev \
      libsuitesparse-dev \
      python-catkin-tools
      
# set up thread number for building
RUN   if [ "x$(nproc)" = "x1" ] ; then export USE_PROC=1 ; \
      else export USE_PROC=$(($(nproc)/2)) ; fi && \
      # Build and install Ceres
      git clone https://ceres-solver.googlesource.com/ceres-solver && \
      cd ceres-solver && \
      git checkout tags/${CERES_VERSION} && \
      mkdir build && cd build && \
      cmake .. && \
      make -j$(USE_PROC) install && \
      rm -rf ../../ceres-solver && \
      mkdir -p $CATKIN_WS/src/VINS-Mono/

# Load VINS-Mono
RUN cd $CATKIN_WS/src && \
    git clone https://github.com/HKUST-Aerial-Robotics/VINS-Mono.git

# Build VINS-Mono
WORKDIR $CATKIN_WS
ENV TERM=xterm
ENV PYTHONIOENCODING=UTF-8
RUN catkin config \
      --extend /opt/ros/$ROS_DISTRO \
      --cmake-args \
        -DCMAKE_BUILD_TYPE=Release && \
    catkin build && \
    sed -i '/exec "$@"/i \
            source "/root/catkin_ws/devel/setup.bash"' /ros_entrypoint.sh

RUN bash -c "echo 'source /root/catkin_ws/devel/setup.bash' >> /root/.bashrc"