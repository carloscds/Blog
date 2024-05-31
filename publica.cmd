git add .
git commit -m "Novo Post"
git push

d:\cds\hugo -b https://carloscds.net/ -d ..\carloscds.github.io
cd ..\carloscds.github.io
git pull
git add .
git commit -m "Novo Post"
git push
cd ..\blog
