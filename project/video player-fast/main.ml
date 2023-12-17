##include<"include.ml">;

Shader_Main{
    N:video_frame;
    var_update(N:name)->N:={
    }
    frame_start()->N:={
        video_frame=GetFloat(&"video0");
    }
    frame_update()->N:={
        return(1);
    }
    frame_end()->N:={
        return(video_frame);//return the texture/buffer which you want to display
    }
    shader_start()->N:={
    }
    shader_end()->N:={
    }
}