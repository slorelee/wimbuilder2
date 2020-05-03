$('body').css("font-family", "'HYGothic', '돋움', 굴림");

$i18n = {
  "Getting Started":"준비 착수",
  "Project":"프로젝트",
  "Customize":"정제",
  "Building":"빌드",
  "About":"정보",
  "Quick build":"빠른 빌드",
  "build(cmd)":"CMD 형식",
  "build(log)":"로그 형식",
  "Browse...":"탐색...",
  "<strong>INFO</strong>:You can set the default settings in 'config.js', and your selection will auto save in 'auto_config.js', make you start quickly for next time. If you want to modify the settings later, use the left-side navigition menu to show this page.":
      "<strong>중요</strong>:사용자는 \"config.js\"에 기본 디폴트 설정을 해 놓을 수 있다, 그리고 사용자가 선택한 값들은 \"auto_config.js\" 에 자동저장되며，다음번 실행할때 빠르게 시작할 수 있게 해줍니다. 나중에 세팅값을 수정하고 싶으면, 좌측 네비게이션 메뉴를 이용해서 이 페이지를 보면 됩니다.",
  "Please configure the base infomation:":"기본정보 설정:",
  "Set the build workspace":"빌드 공간 지정",
  "Select build workspace folder:":"빌드 공간 폴더 선택:",
  "Please select the Windows ISO folder/drive, or the 'sources' folder(auto detect)":"Windows ISO  폴더/드라이브를 선택하세요 , 'sources(=소스)'폴더는 자동 탐지합니다",
  "Select the image path or the 'sources' folder":"Windows 이미지 경로 또는 'sources(=소스)'폴더를 선택하세요",
  "Auto extract the winre.wim":"winre.wim을 자동 압축해제 합니다",
  "<strong>INFO</strong>:The install.wim does not exist.":"<strong>주의</strong>:install.wim이 없는데요 헐.",
  "Select the install.wim file if it needed":"필요하다면 install.wim 파일을 선택하세요",
  "<strong>ERROR</strong>:The base wim does not exist.":"<strong>에러</strong>:베이스 wim이 없는데요 헐.",
  "Select the extracted install.wim folder if it needed":"필요하다면 install.wim이 압축해제 되어있는 폴더를 선택하세요",
  "Select the extracted install.wim folder:":"install.wim이 압축해제 되어있는 폴더를 선택하세요:",
  "Select the base image(boot.wim/winre.wim or other customed.wim)":"베이스 이미지를 선택하세요(boot.wim/winre.wim 또는 사용자 입맛에 맞게 수정된 wim)",
  "Use test\\boot.wim":"test\\boot.wim 을 이용",
  "<strong>Notice</strong>:Please select the correct wim file, and the image index, otherwise cause build failed.":"<STRONG>주의</STRONG>:제대로 된 wim 파일, 그리고 이미지 인덱스를 선택하세요, 그렇지 않으면 빌드는 실패합니다.",

  "Skip when project is selected":"프로젝트가 선택되어 있으면, 지금 단계는 생략",

  "Current project:":"현재 프로젝트:",

  "The _ISO_ folder is not available, you can\'t create bootable ISO image.\r\nPlease make your ISO template manually, or select the Windows ISO folder/drive for auto creating.":
      "현재 _ISO_ 템플릿 디렉토리를 사용할수 없어서, 부팅 ISO 이미지를 생성할 수 없습니다.\r\n수동으로 ISO 템플릿을 만들거나, Windows ISO 이미지 경로를 선택하면 자동으로 만들어집니다.",
  "Subst mounted folder to Drive":"마운트된 폴더에 드라이브 문자 할당하기",
  " Auto":" 자동",
  "<strong>INFO</strong>:If the mounted folder isn't mapping to X:, The patch scripts need use %X%\\ than X:\\ when modifying, deleting the files, and please don't create the shortcuts on building, they may point to the wrong target, do it on booting phase.":
      "<STRONG>주의</STRONG>:만약 마운트된 폴더가 X: 드라이브에 할당되지 않는다면，파일을 수정하거나 삭제할때 패치 스크립트들은 X:\\ 를 사용하기 보다는 %X%\\ 를 사용해야 합니다. 그리고 빌드할때 바로가기(.lnk)를 생성하지 마세요, 왜냐면 부팅 단계에서 잘못된 타겟 드라이브에 매칭될 것이기 때문입니다.",
  "Mapping drive is used":"문자 할당할 드라이브가 이미 사용중입니다",
  "If the Drive is used by the unfinish build, click Continue to go on, it will be fixed,":"제대로 완료되지 않은 빌드 때문에 드라이브가 사용중인 상태로 표시된다면, [계속 진행] 버튼을 클릭해서 진행하세요, 그러면 정상상태로 고쳐질 것입니다.",
  "otherwise, please select an usable drive.":"아니면， 사용안하는 다른 드라이브를 선택하세요.",
  "Continue":"[계속 진행]",
  "Cancel":"취소",
  "0-cleanup":"0-클린업(=정리)",
  "1-build(cmd)":"1-빌드 실행(CMD)",
  "1-build(log)":"1-빌드 실행(로그)",
  "2-make_iso":"2-ISO 제작",
  "Create ISO after building":" 빌드 후 이어서 ISO 제작까지 진행",
  "Execute command after building:":"빌드후 이어서 ISO 테스트할 가상머신 : ",
  "Please input the command.(eg. VBox.cmd testvm)":"이 명령을 입력하십시오.(예:VBox.cmd <가상기계이름>)",
  "Execute":"가상머신 작동",
  "Open log folder":"로그 폴더 열기",
  "Open last build log":"마지막 빌드 로그파일 열기",
  "Please select a project:":"프로젝트를 선택하세요:",
  "Project Information":"프로젝트 정보",


  "Please startup with WimBuilder.cmd.":"WimBuilder.cmd 로 시작하세요.",
  "No project to build.":"빌드할 프로젝트가 없음.",
  "Do you want to build the [%s] project?":"[%s] 프로젝트를 빌드하시겠습니까？",
  "Please select a project for building.":"빌드할 프로젝트를 선택하세요.",
  "The system cannot find the file specified.":"지정한 파일을 찾을 수 없습니다.",
  "#LASTDUMMY#":""
}
