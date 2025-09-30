FROM ros:humble-perception

SHELL ["/bin/bash", "-c"]

RUN apt-get update && apt-get install -y '~nros-humble-rqt*'




WORKDIR /root
RUN git clone https://github.com/Livox-SDK/Livox-SDK2.git
RUN cd Livox-SDK2 && mkdir build && cd build &&\
    cmake .. -DCMAKE_POLICY_VERSION_MINIMUM=3.5 &&\
    make -j9 &&\
    make install

RUN git clone https://github.com/Livox-SDK/livox_ros_driver2.git ws_livox/src/livox_ros_driver2
RUN source /opt/ros/humble/setup.sh && ~/ws_livox/src/livox_ros_driver2/build.sh humble

    
RUN bash -c "echo 'source /root/ws_livox/install/setup.bash' >> /root/.bashrc"