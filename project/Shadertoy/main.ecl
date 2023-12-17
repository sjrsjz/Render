/*A very huge shader project*/
##define Frame_W 200;
##define Frame_H 100;
##include<"include.ecl">;

int buf0;int buf1;
int buf0_s;
int buf1_s;
int buf2_s;

double time;
int SizeW;int SizeH;
int Frame;
int bufA;int bufB;
int bufM;

/*some textures for shadertoy*/
int texA;
int texB;
int texC;
int texD;

DLL:"opengl32.dll"{
    int glTexParameteri:glTexParameteri(int target,int pname,int a);
    int glBindTexture:glBindTexture(int target,int id)
}

int front;int Offset;
int lOffset;
Vec4 Position2D;
Vec4 Position;
Vec4 mouse;
double scale;double dt;
int var_update(int name){
    Frame=0;front=1
}
int frame_start(){
    Offset=GetFloat(&"offset");
    scale=GetFloat(&"scale");
    dt=GetFloat(&"dt");
    getVec4(&"Position2D",Position2D);
    getVec4(&"Position",Position);
    getVec4(&"Mouse",mouse);
    if(lOffset!=Offset){Frame=0};
    lOffset=Offset;
    front=-front;
    bufA=buf0;bufB=buf1;
   // if(front==1){bufA=buf1;bufB=buf0};
    time(time);
}
int setUniforms(){
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
int frame_update(){
    Shader(buf1_s);
    Buf(bufA,0);

    /*Bind textures,the last parameter means the dimension of the texture,like 1,2,3*/
    Tex(bufA,0,2);
    Tex(texC,2,2);
    Tex(texD,3,3);

    setUniforms();
    int size0=SizeW/DefaultPixelSize;
    int size1=SizeH/DefaultPixelSize;
    compute(size0,size1,1);

    Shader(buf2_s);
    Buf(bufB,0);
    /*Bind textures,the last parameter means the dimension of the texture,like 1,2,3*/
    Tex(bufB,0,2);
    Tex(bufA,1,2);
    Tex(texC,2,2);
    Tex(texD,3,3);

    setUniforms();
    compute(size0,size1,1);

    Shader(buf0_s);
    Buf(bufM,0);
    /*Bind textures,the last parameter means the dimension of the texture,like 1,2,3*/
    Tex(bufB,0,2);
    Tex(bufA,1,2);
    setUniforms();
    compute(size0,size1,1);


    Shader(0);
    return(1);/*if zero,then keep updating*/
}
int frame_end(){
    Frame=Frame+1;
    return(bufM);/*return the texture/buffer which you want to display*/
}
int shader_start(){
    /*Load textures from files*/
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
    front=1;
    lOffset=0;
    SizeW=DefaultSize;SizeH=SizeW*#H/#W;
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
int shader_end(){
    freeTex(buf0);freeTex(buf1);freeTex(bufM);
    freeTex(texA);freeTex(texB);freeTex(texC);freeTex(texD)
}