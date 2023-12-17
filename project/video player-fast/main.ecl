##include<"include.ecl">;
int video_frame;

int var_update(int name){
}
int frame_start(){
    video_frame=GetFloat(&"video0");
}
int frame_update(){
    return(1);/*if zero,then keep updating*/
}
int frame_end(){
    return(video_frame);
}
int shader_start(){
}
int shader_end(){
}