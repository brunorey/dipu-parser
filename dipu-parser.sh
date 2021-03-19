#!/bin/bash
rm -rf ./output
mkdir output
echo "" > output/proyectos-por-diputado.html
echo -n "Obteniendo listado de diputados... "
curl -s 'https://www.hcdn.gob.ar/diputados/listadip.html' | grep '<a href=[a-z]*>' | grep -o '=[a-z]*>' | sed -e 's/=//' | sed -e 's/>//' > output/lista-de-diputados.txt
cant_de_diputados=$(wc -l output/lista-de-diputados.txt | sed -e 's/[^0-9]*//g')
totaldips=$(printf '%03d' "${cant_de_diputados}")
i=1
echo "$totaldips encontrados."


echo '<table id="tablesorter" cellspacing="1" class="tablesorter tabla-proyectos textLeft col-xs-12">
	<thead>		
		<tr>
			<th id="dipHead"><div class="tit-ts">Diputado</div> <div class="flechas"></div> </th>
			<th id="pagHead"><div class="tit-ts">Página</div> <div class="flechas"></div> </th>
			<th id="expHead"><div class="tit-ts">Expediente</div> <div class="flechas"></div> </th>
			<th id="tipoHead"><div class="tit-ts">Tipo</div> <div class="flechas"></div> </th>
			<th id="sumHead"><div class="tit-ts">Sumario</div> <div class="flechas"></div> </th>
			<th id="fechaHead"><div class="tit-ts">Fecha</div> <div class="flechas"></div> </th>
		</tr>
	</thead>	
	<tbody>' > output/proyectos-por-diputado.html

cat output/lista-de-diputados.txt | while read -r diputado; do 
    paddeddip=$(printf '%03d' "$i")
    echo "$paddeddip/$totaldips: diputado $diputado"
    paginas=$(curl -s https://www.hcdn.gob.ar/diputados/${diputado}/listadodeproy.html\?pagina\=1 | grep -o 'Página 1 de [0-9]*' | head -n 1 | grep -o '[0-9]*$');
    if [[ -z $paginas ]]; then
        paginas=1
    fi
    echo -n "    descargando $paginas paginas: "
    for pag in $(seq 1 $paginas); do
        paddedpag=$(printf '%03d' "$pag")
        echo -n ",$pag"
        link="https://www.hcdn.gob.ar/diputados/${diputado}/listadodeproy.html?pagina=${pag}"
        curl -s "$link" > output/diputado-${diputado}_p${paddedpag}_completa.html
        cat output/diputado-${diputado}_p${paddedpag}_completa.html | sed '/tabla-proyectos/,$!d' | sed '/section-bottom-menu/,$d' | sed "s/href='\/proyectos\/proyecto/href='https:\/\/www.hcdn.gob.ar\/proyectos\/proyecto/" | grep -E '^<td|^\t?<tr' | sed "s/<tr>/<tr><td><a href=\"https\:\/\/www.hcdn.gob.ar\/diputados\/${diputado}\">${diputado}<\/a><\/td><td><a href=\"https\:\/\/www.hcdn.gob.ar\/diputados\/${diputado}\/listadodeproy.html\?pagina\=${pag}\">${paddedpag} de ${paginas}<\/a><\/td>/" > output/diputado-${diputado}_p${paddedpag}.html
        cat output/diputado-${diputado}_p${paddedpag}.html >> output/proyectos-por-diputado.html
        rm output/diputado-${diputado}_p${paddedpag}_completa.html
        rm output/diputado-${diputado}_p${paddedpag}.html
    done
    echo ""
    i=$((i+1))
done
echo '</tbody></table>' >> output/proyectos-por-diputado.html
