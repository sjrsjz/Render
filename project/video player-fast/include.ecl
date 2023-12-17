int getFunc;
int setFunc;
int buffer1D;
int buffer2D;
int buffer3D;
int Buf;
int compute;
int freeTex;
int Shader;
int getShader;
int setF;
int setF3;
int setI;
int setI3;
int setD;
int setD3;
int setF4;
int setEyeMat;
int setVar;
int getTime;
int getFloat;
int getVec4;
int LoadTex;
int Tex;
int getFFT;
int playFFT;

int DefaultSize;
int DefaultPixelSize;
int DefaultLineSize;
int ifOutputBigImage;

Vec4{double x,double y,double z,double w}
int main(int a,int b){
    getFunc=a;setFunc=b;
    buffer1D=getFunc(&"buffer1D");
    buffer2D=getFunc(&"buffer2D");
    buffer3D=getFunc(&"buffer3D");
    Buf=getFunc(&"Buf");
    compute=getFunc(&"compute");
    freeTex=getFunc(&"freeTex");
    Shader=getFunc(&"Shader");
    getShader=getFunc(&"getShader");
    setF=getFunc(&"setF");
    setF3=getFunc(&"setF3");
    setF4=getFunc(&"setF4");
    setI=getFunc(&"setI");
    setI3=getFunc(&"setI3");
    setD=getFunc(&"setD");
    setD3=getFunc(&"setD3");
    setVar=getFunc(&"setVar");
    setEyeMat=getFunc(&"setEyeMat");
    Tex=getFunc(&"Tex");
    LoadTex=getFunc(&"LoadTex");
    getFloat=getFunc(&"getFloat");
    getVec4=getFunc(&"getVec4");
    getTime=getFunc(&"time");
    getFFT=getFunc(&"getFFT");
    playFFT=getFunc(&"playFFT");
    setFunc(&"frame_start",~frame_start);
    setFunc(&"frame_end",~frame_end);
    setFunc(&"frame_update",~frame_update);
    setFunc(&"shader_end",~shader_end);
    setFunc(&"var_update",~var_update);

    double t;
    getFloat(&"DefaultSize",t);DefaultSize=t;
    getFloat(&"DefaultPixelSize",t);DefaultPixelSize=t;
    getFloat(&"DefaultLineSize",t);DefaultLineSize=t;
    getFloat(&"ifOutputBigImage",t);ifOutputBigImage=t;
    shader_start();
}
int setVec4(int str,Vec4 vec){setF4(str,vec.x,vec.y,vec.z,vec.w)}
int setVec3(int str,Vec4 vec){setF3(str,vec.x,vec.y,vec.z)}
int getFunc(int str){return(callFunc(getFunc))}
int setFunc(int str,int ad){return(callFunc(setFunc))}
int buffer1D(int size){return(callFunc(buffer1D))}
int buffer2D(int w,int h){return(callFunc(buffer2D))}
int buffer3D(int l,int w,int h){return(callFunc(buffer3D))}
int Buf(int id,int unit){return(callFunc(Buf))}
int freeTex(int id){return(callFunc(freeTex))}
int Shader(int id){return(callFunc(Shader))}
int getShader(int str){return(callFunc(getShader))}
int compute(int l,int w,int h){return(callFunc(compute))}
int setVar(int str){return(callFunc(setVar))}
int setF(int str,double x){return(callFunc(setF))}
int setF3(int str,double x,double y,double z){return(callFunc(setF3))}
int setD(int str,double x){return(callFunc(setD))}
int setD3(int str,double x,double y,double z){return(callFunc(setD3))}
int setI(int str,int x){return(callFunc(setI))}
int setI3(int str,int x,int y,int z){return(callFunc(setI3))}
int setF4(int str,double x,double y,double z,double w){return(callFunc(setF4))}
int time(@double t){return(callFunc(getTime))}
int setEyeMat(int str){return(callFunc(setEyeMat))}
int Tex(int id,int bind,int dim){return(callFunc(Tex))}
int LoadTex(int str){return(callFunc(LoadTex))}
int playFFT(int tex,int stream,int length,int start,int playlength){return(callFunc(playFFT))}
int getFloat(int str,@double t){return(callFunc(getFloat))}
int getVec4(int str,Vec4 t){return(callFunc(getVec4))}
int getFFT(int str,int tex,int size){return(callFunc(getFFT))}
double GetFloat(int str){double t;getFloat(str,t);return(t)}