git add .
git commit -m "Novo Post"
git push

cd ..\carloscds.github.io
git pull
cd ..\projeto

d:\cds\hugo -b https://carloscds.net/ -d ..\carloscds.github.io
cd ..\carloscds.github.io
git add .
git commit -m "Novo Post"
git push
cd ..\projeto
