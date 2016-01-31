cd images
rm -r full
rm -r thumbs
mkdir full
mkdir thumbs
cat ../sourcehtml ../righthtml ../template.html | grep -o 'full\/[^\"\/]*\.[jJ][pP][gG]' | sort | uniq | sed 's/full\///' | sed 's/\(.*\)/cp ~\/Dropbox\/RP\/websiteimages\/\1 full/' | sh
cat ../sourcehtml ../righthtml ../template.html | grep -o 'thumbs\/[^\"\/]*\.[jJ][pP][gG]' | sort | uniq | sed 's/thumbs\///' | sed 's/\(.*\)/cp ~\/Dropbox\/RP\/websiteimages\/\1 thumbs/' | sh
#cp ~/Dropbox/RP/websiteimages/*.JPG full
#cp ~/Dropbox/RP/websiteimages/*.jpg full
#cp ~/Dropbox/RP/websiteimages/*.JPG thumbs
#cp ~/Dropbox/RP/websiteimages/*.jpg thumbs
cd full
mogrify -resize 1024x768 *.JPG
mogrify -resize 1024x768 *.jpg
cd ..
cd thumbs
mogrify -resize 78x59! *.JPG
mogrify -resize 78x59! *.jpg
cd ..
cd ..

#mkdir visitor
#mkdir feedback
#cp ../visitor/*anon* visitor
#cp ../feedback/* feedback
#cd feedback
#mogrify -resize 750x1000 *.JPG
#mogrify -resize 750x1000 *.jpg
#cd ..
#cd visitor
#mogrify -resize 1000x750 *.JPG
#mogrify -resize 1000x750 *.jpg
#cd ..
