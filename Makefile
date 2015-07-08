IMAGE="diogocp/android-x86:4.4-r2"
LIVECD="android-x86-4.4-r2.iso"
BASE_URL="https://sourceforge.net/projects/android-x86/files/Release%204.4/"

all: docker

docker: system.tar
	docker build -t ${IMAGE} .

system.tar:
	[ -f ${LIVECD} ] || wget '${BASE_URL}${LIVECD}'
	7z e -y ${LIVECD} system.sfs
	7z e -y system.sfs system.img
	[ -d system ] || mkdir system
	sudo mount -o ro system.img system
	sudo tar --exclude="system/lost+found" -cpf system.tar system
	sudo umount system

clean:
	[ -d system ] && rmdir system
	rm ${LIVECD} system.sfs system.img
