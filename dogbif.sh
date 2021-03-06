echo "removing any quotes in Taxon.tsv"
# sed -i '' 's/\"//g' Taxon.tsv
sed -i 's/\"//g' Taxon.tsv
sqlite3 gbif.sqlite < schema.sql
echo "quotes removed; now loading database"
echo '.mode tabs\n.separator "\\t"\n.header off\n.import Taxon.tsv gbif' | sqlite3 gbif.sqlite
echo "CREATE UNIQUE INDEX id on gbif (taxonID);" | sqlite3 gbif.sqlite
echo "CREATE INDEX conname on gbif (canonicalName);" | sqlite3 gbif.sqlite
echo "CREATE INDEX sciname on gbif (scientificName);" | sqlite3 gbif.sqlite
echo "CREATE INDEX parname on gbif (parentNameUsageID);" | sqlite3 gbif.sqlite
echo "\nall done!"
