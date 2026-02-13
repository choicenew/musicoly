INNO_VERSION=6.2.0
TEMP_DIR=/tmp/pyro_music-tar
USR_SHARE=deb-struct/usr/share
BUNDLE_DIR=build/linux/${ARCH}/release/bundle
MIRRORLIST=${PWD}/build/mirrorlist

tar:
		mkdir -p $(TEMP_DIR)\
		&& cp -r $(BUNDLE_DIR)/* $(TEMP_DIR)\
		&& cp linux/pyro_music.desktop $(TEMP_DIR)\
		&& cp assets/pyro_music-logo.png $(TEMP_DIR)\
		&& cp linux/com.github.KRTirtho.Pyro Music.appdata.xml $(TEMP_DIR)\
		&& tar -cJf build/pyro_music-linux-${VERSION}-${PKG_ARCH}.tar.xz -C $(TEMP_DIR) .\
		&& rm -rf $(TEMP_DIR)

aursrcinfo:
					 docker run -e EXPORT_SRC=1 -v ${PWD}/aur-struct:/pkg -v ${MIRRORLIST}:/etc/pacman.d/mirrorlist:ro whynothugo/makepkg

publishaur: 
					 echo '[Warning!]: you need SSH paired with AUR'\
					 && rm -rf build/pyro_music\
					 && git clone ssh://aur@aur.archlinux.org/pyro_music-bin.git build/pyro_music\
					 && cp aur-struct/PKGBUILD aur-struct/.SRCINFO build/pyro_music\
					 && cd build/pyro_music\
					 && git add .\
					 && git commit -m "${MSG}"\
					 && git push

innoinstall:
						powershell curl -o build\installer.exe http://files.jrsoftware.org/is/6/innosetup-${INNO_VERSION}.exe
						powershell git clone https://github.com/DomGries/InnoDependencyInstaller.git  build\inno-depend
		 				powershell build\installer.exe /verysilent /allusers /dir=build\iscc

inno:
		 powershell .\build\iscc\iscc.exe scripts\windows-setup-creator.iss

choco:
			powershell cp dist\Pyro Music-windows-x86_64-setup.exe choco-struct\tools
			powershell choco pack .\choco-struct\pyro_music.nuspec  --outputdirectory dist

apk:
		mv build/app/outputs/apk/release/app-release.apk build/Pyro Music-android-all-arch.apk

gensums:
				sh -c scripts/gensums.sh

migrate:
				dart run drift_dev make-migrations