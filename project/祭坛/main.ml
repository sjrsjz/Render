/*Created by sjz1*/
##include<"include.ml">;

Shader_Main{
    N:buf0;N:buf1;
    N:buf0_s;
    R:time;
    N:SizeW;N:SizeH;
    N:Frame;
    N:bufA;N:bufB;N:buf2;N:buf3;
    N:texA;
    N:texB;
    Boolen:front;N:Offset;
    N:lOffset;
    vec4:Position2D;vec4:Position;
    R:scale;
    
    var_update(N:name)->N:={
        
        Frame=0;front=true
    }
    frame_start()->N:={
        Offset=GetFloat(&"offset");
        scale=GetFloat(&"scale");
        getVec4(&"Position2D",Position2D);
        getVec4(&"Position",Position);
        if(lOffset!=Offset){
            Frame=0
        };
        lOffset=Offset;
        front=not front;
        bufA=buf0;bufB=buf1;
        if(front){
            bufA=buf1;bufB=buf0
        };
        time(&time);
    }
    frame_update()->N:={
        Shader(buf0_s);
        Buf(bufA,0);Buf(bufB,1);
        Buf(buf2,2);Buf(buf3,3);
        Tex(texA,0,2);
        Tex(texB,1,2);
        setF(&"iTime",time);
        setI(&"Raw_iFrame",Frame);
        setI(&"iOffset",Offset);
        setI(&"iW",SizeW);
        setI(&"iH",SizeH);
        setI(&"ifOutputRAW",ifOutputRAW);
        setI(&"ifOutputBigImage",ifOutputBigImage);
        setF(&"scale",scale);
        setVec4(&"Position2D",Position2D);
        setVec3(&"Position",Position);
        setEyeMat(&"Eye_Mat");
        setI(&"CutSize",DefaultLineSize*DefaultPixelSize);
        N:size0=SizeW/DefaultPixelSize;
        N:size1=SizeH/DefaultPixelSize;
        compute(size0,size1,1);
        Shader(0);
        return(1);//if zero,then keep updating
    }
    frame_end()->N:={
        Frame=Frame+1;
        return(bufB);//return the texture/buffer which you want to display
    }
    shader_start()->N:={
        texA=LoadTex(&"texture\noise.bmp");
        texB=LoadTex(&"texture\2.bmp");
        Frame=0;
        front=true;
        lOffset=0;
        SizeW=DefaultSize;SizeH=SizeW;
        if(ifOutputBigImage!=0){
            SizeH=DefaultLineSize*DefaultPixelSize;
        };
        buf0=buffer2D(SizeW,SizeH);
        buf1=buffer2D(SizeW,SizeH);
        buf2=buffer2D(SizeW,SizeH);
        buf3=buffer2D(SizeW,SizeH);
        buf0_s=getShader(&"Raytracer");
    }
    shader_end()->N:={
        freeTex(buf0);freeTex(buf1);freeTex(buf2);
        freeTex(texA);freeTex(texB);freeTex(buf3);
    }
}