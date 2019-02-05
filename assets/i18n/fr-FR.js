$('body').css("font-family", "'Open Sans', Arial");

$i18n = {
  "Getting Started":"Démarrage",
  "Project":"Projet",
  "Patches":"Fonctionnalités",
  "Building":"Building",
  "About":"A Propos",
  "Quick build":"Quick build",
  "run(cmd)":"run(cmd)",
  "exec(log)":"exec(log)",
  "Browse...":"Browse...",
  "<strong>INFO</strong>:You can set the default settings in 'config.js', and your selection will auto save in 'auto_config.js', make you start quickly for next time. If you want to modify the settings later, use the left-side navigition menu to show this page.":
      "<strong>INFO</strong>:Vous pouvez définir les paramètres par défaut dans 'config.js'. Votre sélection sera automatiquement enregistrée dans 'auto_config.js'. Vous commencerez ainsi plus rapidement la prochaine fois. Si vous souhaitez ensuite modifier ces paramètres, utilisez le menu de navigition sur le côté gauche pour afficher cette page.",
  "Please configure the base infomation:":"Veuillez configurer les informations de base:",
  "Set the build workspace":"Définir l'espace de travail",
  "Select build workspace folder:":"Sélectionnez le dossier de l'espace de travail:",
  "Please select the Windows ISO folder/drive, or the 'sources' folder(auto detect)":"Veuillez sélectionner le dossier/lecteur ISO de Windows, ou le dossier 'sources' (détection automatique)",
  "Select the image path or the 'sources' folder":"Sélectionnez le chemin de l'image ou le dossier 'sources'",
  "Auto extract the winre.wim":"Extraction automatique du fichier WinRE. wim",
  "<strong>INFO</strong>:the install.wim isn't exist.":"<strong>INFO</strong>:le fichier 'Install.wim' n'existe pas.",
  "Select the install.wim file if it needed":"Sélectionnez le fichier 'Install.wim' si nécessaire",
  "<strong>ERROR</strong>:the base wim isn't exist.":"<strong>ERROR</strong>:le fichier de base Wim n'existe pas.",
  "Select the extracted install.wim folder if it needed":"Sélectionnez le dossier de 'install.wim' si nécessaire",
  "Select the extracted install.wim folder:":"Sélectionnez le dossier de 'install.wim':",
  "Select the base image(boot.wim/winre.wim or other customed.wim)":"Sélectionnez le fichier image de base (Boot. wim/WinRE. wim ou autre customed.wim)",
  "Use test\\boot.wim":"Use test\\boot.wim",
  "<strong>Notice</strong>:Please select the correct wim file, and the image index, otherwise cause build failed.":"<STRONG>Notice</STRONG>:Veuillez sélectionner le fichier WIM correct et l'index de l'image, sinon la génération échouera.",

  "Skip when project is selected":"Ignorer lorsque le projet est sélectionné",

  "Current project:":"Projet actuel:",

  "The _ISO_ folder is not available, you can\'t create bootable ISO image.\r\nPlease make your ISO template manually, or select the Windows ISO folder/drive for auto creating.":
      "Le dossier _ ISO_ n'est pas disponible, vous ne pouvez pas créer d'image ISO amorçable.\r\nCréez un modèle ISO manuellement, ou sélectionnez le chemin de l'image ISO de Windows et il sera créé automatiquement.",
  "Subst mounted folder to Drive":"Assignation de lettre de lecteur au dossier monté",
  " Auto":" Auto",
  "<strong>INFO</strong>:If the mounted folder isn't mapping to X:, The patch scripts need use %X%\\ than X:\\ when modifying, deleting the files, and please don't create the shortcuts on building, they may point to the wrong target, do it on booting phase.":
      "<STRONG>INFO</STRONG>:Si le dossier monté n'est pas assigné au lecteur X:, les scripts des fonctionnalités doivent utiliser %X%\\ au lieu de X:\\, lors de la modification ou de la suppression de fichiers. Et ne créez pas de raccourci (.lnk) lorsque vous le générez, car il correspondra à un lecteur 'cible' incorrect pendant la phase de démarrage.",
  "Mapping drive is used":"Le lecteur est déjà utilisé",
  "If the Drive is used by the unfinish build, click Continue to go on, it will be fixed,":"Si le lecteur est marqué comme utilisé en raison d'un build qui ne s'est pas terminé avec succès, cliquez sur le bouton 'Continuer' pour poursuivre, il retrouvera l'état normal.",
  "otherwise, please select an usable drive.":"Ou choisissez un autre lecteur que vous n'utilisez pas.",
  "Continue":"[Continuer]",
  "Cancel":"Annuler",
  "0-cleanup":"0-cleanup",
  "1-run(cmd)":"1-run(cmd)",
  "1-exec(log)":"1-exec(log)",
  "2-make_iso":"2-make_iso",
  "Create ISO after building":" Build et création de l'ISO",
  "Test ISO after building with:":"Tester l'ISO dans une machine virtuelle après la construction:",
  "Launch":"Lancement du test",
  "Open log folder":"Ouvrir le dossier de log",
  "Open last build log":"Ouvrir le dernier fichier journal de build",
  "Please select a project:":"Sélectionner un projet:",
  "Project Information":"Informations sur le projet",


  "Please startup with WimBuilder.cmd.":"Commencez avec Wimbuilder.cmd.",
  "No project to build.":"Aucun projet à construire.",
  "Do you want to build the [%s] project?":"Voulez-vous créer le projet [%s]?",
  "Please select a project for building.":"Sélectionnez le projet que vous souhaitez créer.",
  "The system cannot find the file specified.":"Le fichier spécifié n'a pas été trouvé.",
  "#LASTDUMMY#":""
}
