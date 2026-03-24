source /arch-detect.sh
machine=$(uname -m)
case "$machine" in
    x86_64)
        host_arch="x86_64"
        build_arch="x86_64"
        ;;
    aarch64|arm64)
        host_arch="aarch64"
        build_arch="aarch64"
        ;;
    armv7l)
        host_arch="armv7l"
        build_arch="armv7l"
        ;;
    *)
        echo "Unsupported architecture: $machine"
        exit 1
        ;;
esac

curl -L https://ftp.gnu.org/gnu/gforth/gforth-0.7.3.tar.gz -o forth.tar.gz
tar xzf forth.tar.gz
rm forth.tar.gz

cd gforth-0.7.3/
./BUILD-FROM-SCRATCH --host="$host_arch" --build="$build_arch"

make
make install

chmod +x ./gforth
cd ..
