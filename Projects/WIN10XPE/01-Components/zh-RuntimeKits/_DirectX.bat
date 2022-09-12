call AddFiles %0 :[DirectX_Files]
call AddDrivers "dba.inf,ks.inf,kscaptur.inf,ksfilter.inf"
goto :EOF

:[DirectX_Files]
@\Windows\System32\
;already exist in Winre.wim: dxgkrnl.sys,dxgmms1.sys,ks.sys,mskssrv.sys,mspclock.sys,mspqm.sys,mstee.sys,stream.sys
drivers\gm.dls

+syswow64
glmf32.dll,glu32.dll,opengl32.dll

;Microsoft Direct2D
d2d1.dll

;Direct3D 9 Runtime
d3d9.dll,d3d9on12.dll

;Direct3D 10 Runtime
d3d10.dll,d3d10core.dll,d3d10level9.dll
d3d10warp.dll,d3d10_1.dll,d3d10_1core.dll

;Direct3D 11 Runtime
d3d11.dll,d3d11on12.dll

;Direct3D 12 Runtime
D3D12.dll,D3D12Core.dll

d3d8thk.dll,D3DCompiler_47.dll

;DirectDisplay,  DirectDraw
ddisplay.dll,ddraw.dll,ddrawex.dll

;Microsoft DirectInput
dinput.dll,dinput8.dll,Direct2DDesktop.dll

;DirectSound
dsdmo.dll,dsound.dll

;Microsoft DirectMusic
dmloader.dll,dmsynth.dll,dmusic.dll,dswave.dll

;DirectPlay Stub
dpnaddr.dll,dpnathlp.dll,dpnet.dll,dpnhpast.dll
dpnhupnp.dll,dpnlobby.dll,dpnsvr.exe

;Microsoft DirectX
DWrite.dll,DXCaptureReplay.dll,DXCpl.exe
dxdiag.exe,dxdiagn.dll,dxgi.dll,dxgwdi.dll
dxilconv.dll,dxtmsft.dll,dxtrans.dll,dxva2.dll
mscat32.dll

;DirectShow
amstream.dll,cca.dll
mciqtz32.dll,mfds.dll,mpg2splt.ax

qasf.dll,qcap.dll,qdv.dll,qdvd.dll,qedit.dll
qedwipes.dll,quartz.dll,sbe.dll,sberes.dll

CompPkgSup.dll,CPFilters.dll,dciman32.dll,dispex.dll
ksproxy.ax,kstvtune.ax,ksuser.dll,Kswdmcap.ax,ksxbar.ax,Mpeg2Data.ax
MSAC3ENC.DLL,iyuv_32.dll

goto :EOF
