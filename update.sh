GITHUB_SHA=$(git ls-remote https://github.com/Insomnia-IT/intronet-front | head -1 | awk '{print $1}')
echo "${GITHUB_SHA}"
CURRENT=$(cat .env | tail -1 | sed -e s/GITHUB_SHA=//g)
echo $CURRENT
if [ $CURRENT = $GITHUB_SHA ]; then
	echo "no changes"
else
	cat .env | sed -e s/${CURRENT}/${GITHUB_SHA}/g | tee .env
	docker compose up -d
fi
