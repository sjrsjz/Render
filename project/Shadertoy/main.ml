/*Created by sjz1*/
##include<"include.ml">;

/*A very huge shader project*/
##define Frame_W 16;
##define Frame_H 10;

Extra:"opengl32.dll"{
    glTexParameteri(N:target,N:pname,N:a)->N:=glTexParameteri;
    glBindTexture(N:target,N:id)->N:=glBindTexture
}
Shader_Main{
    N:buf0;N:buf1;
    N:buf0_s;
    N:buf1_s;
    N:buf2_s;
    
    R:time;
    N:SizeW;N:SizeH;
    N:Frame;
    N:bufA;N:bufB;
    N:bufM;
    
    //some textures for shadertoy
    N:texA;
    N:texB;
    N:texC;
    N:texD;
    
    N:front;N:Offset;
    N:lOffset;
    vec4:Position2D;
    vec4:Position;
    vec4:mouse;
    R:scale;R:dt;
    setUniforms()->N:={
        setF(&"iTime",time);
        setF(&"iTimeDelta",dt);
        setI(&"iFrame",Frame);
        setI(&"iOffset",Offset);
        setI(&"iW",SizeW);
        setI(&"iH",SizeH);
        setI(&"ifOutputBigImage",ifOutputBigImage);
        setF(&"scale",scale);
        setVec4(&"Position2D",Position2D);
        setVec3(&"Position",Position);
        setVec3(&"mouse",mouse);
        setEyeMat(&"Eye_Mat");
    }
    var_update(N:name)->N:={
        
        Frame=0;front=true
    }
    frame_start()->N:={
        Offset=GetFloat(&"offset");
        scale=GetFloat(&"scale");
        dt=GetFloat(&"dt");
        getVec4(&"Position2D",Position2D);
        getVec4(&"Position",Position);
        getVec4(&"Mouse",mouse);
        if(lOffset!=Offset){Frame=0};
        lOffset=Offset;
        front=not front;
        bufA=buf0;bufB=buf1;
        time(&time);
    }
    frame_update()->N:={
        Shader(buf1_s);
        Buf(bufA,0);
    
        //Bind textures,the last parameter means the dimension of the texture,like 1,2,3
        Tex(bufA,0,2);
        Tex(texC,2,2);
        Tex(texD,3,3);
    
        setUniforms();
        N:size0=SizeW/DefaultPixelSize;
        N:size1=SizeH/DefaultPixelSize;
        compute(size0,size1,1);
    
        Shader(buf2_s);
        Buf(bufB,0);
        //Bind textures,the last parameter means the dimension of the texture,like 1,2,3
        Tex(bufB,0,2);
        Tex(bufA,1,2);
        Tex(texC,2,2);
        Tex(texD,3,3);
    
        setUniforms();
        compute(size0,size1,1);
    
        Shader(buf0_s);
        Buf(bufM,0);
        //Bind textures,the last parameter means the dimension of the texture,like 1,2,3
        Tex(bufB,0,2);
        Tex(bufA,1,2);
        setUniforms();
        compute(size0,size1,1);
    
    
        Shader(0);
        return(1);//if zero,then keep updating
    }
    frame_end()->N:={
        Frame=Frame+1;
        return(bufM);//return the texture/buffer which you want to display
    }
    shader_start()->N:={
        //Load textures from files
        texA=LoadTex(&"texture\surface.bmp");
        texB=LoadTex(&"texture\1.bmp");
        texC=LoadTex(&"texture\noise.bmp");
        texD=buffer3D(32,32,32);
        glBindTexture(32879,texD);
        glTexParameteri(32879,10242,10497);
        glTexParameteri(32879,10243,10497);
        glTexParameteri(32879,32882,10497);
        glTexParameteri(32879,10240,9729);
        glTexParameteri(32879,10241,9987);
        glBindTexture(32879,0);
        Shader(getShader(&"buf3D"));
        Buf(texD,0);
        compute(4,4,4);
        Shader(0);
    
        Frame=0;
        front=true;
        lOffset=0;
        SizeW=DefaultSize;SizeH=SizeW*Frame_H/Frame_W;
        if(ifOutputBigImage!=0){
            SizeH=DefaultLineSize*DefaultPixelSize;
        };
        buf0=buffer2D(SizeW,SizeH);
        buf1=buffer2D(SizeW,SizeH);
        bufM=buffer2D(SizeW,SizeH);
        buf0_s=getShader(&"buf0");
        buf1_s=getShader(&"buf1");
        buf2_s=getShader(&"buf2");
    }
    shader_end()->N:={
        freeTex(buf0);freeTex(buf1);freeTex(bufM);
        freeTex(texA);freeTex(texB);freeTex(texC);freeTex(texD)
    }
}