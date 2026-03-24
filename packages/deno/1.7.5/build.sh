source /arch-detect.sh
architecture=$(get_arch_long)
curl -L "https://github.com/denoland/deno/releases/download/v1.7.5/deno-${architecture}.zip" --output deno.zip
unzip -o deno.zip
rm deno.zip

chmod +x deno
