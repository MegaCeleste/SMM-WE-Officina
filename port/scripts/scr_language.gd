# from scripts/scr_language/scr_language.gml
# 第 2 批移植，已核对。
extends RefCounted


# from scripts/scr_language/scr_language.gml
static func scr_language(me: GMObject, argument0: float = 0.0) -> Variant:
	if G.idioma == 0.0:
		match argument0:
			0.0:
				return "¡ADVERTENCIA!"
			1.0:
				return "Este es un 'Fan Game' (de fans para fans)#por lo cual no está respaldado por Nintendo.#Todas las imágenes, músicas y recursos utilizados#en este son propiedad de Nintendo."
			2.0:
				return "Lunes"
			3.0:
				return "Martes"
			4.0:
				return "Miércoles"
			5.0:
				return "Jueves"
			6.0:
				return "Viernes"
			7.0:
				return "Sábado"
			8.0:
				return "Ya es domingo, ¡a hacer niveles se ha dicho!"
			9.0:
				return "Feliz Navidad <3"
			10.0:
				return "¡Feliz Año Nuevo!"
			11.0:
				return "Jugar"
			12.0:
				return "Crear un nivel"
			13.0:
				return "Desafío Super Mario"
			14.0:
				return "Niveles Mundiales"
			15.0:
				return "Guardabot"
			16.0:
				return "Español"
			17.0:
				return "NOMBRE DE USUARIO"
			18.0:
				return "INICIAR SESION"
			19.0:
				return "AJUSTES"
			20.0:
				return "Controles"
			21.0:
				return "Idioma"
			22.0:
				return "Personaje"
			23.0:
				return "Sonidos"
			24.0:
				return "Pantalla"
			25.0:
				return "Efectos Especiales"
			26.0:
				return "Controles Táctiles"
			27.0:
				return "Controles SM4J"
			28.0:
				return "Aceptar"
			29.0:
				return "Configurar"
			30.0:
				return "Activado"
			31.0:
				return "Desactivado"
			32.0:
				return "Programadores"
			33.0:
				return "Sonido/Música"
			34.0:
				return "Animación y Efectos"
			35.0:
				return "Tipografía"
			36.0:
				return "Contribuciones Adicionales"
			37.0:
				return "Agradecimientos Especiales"
			38.0:
				return "Power by/Recursos"
			39.0:
				return "Ninguno"
			40.0:
				return "Lento"
			41.0:
				return "Normal"
			42.0:
				return "Rápido"
			43.0:
				return "Acciones"
			44.0:
				return "Elementos"
			45.0:
				return "Estado"
			46.0:
				return "Llega a la meta sin recibir daño"
			47.0:
				return "Llega a la meta sin tocar el suelo una vez que #hayas separado los pies de él"
			48.0:
				return "Llega a la meta sin salir del agua"
			49.0:
				return "Llega a la meta sin recoger ninguna moneda"  # continua
			50.0:
				return "Editar"
			51.0:
				return "Publicar"
			52.0:
				return "Tradicional"
			53.0:
				return "Puzles"
			54.0:
				return "Contrarreloj"
			55.0:
				return "Autoavance"
			56.0:
				return "Automatismos"
			57.0:
				return "Corto pero intenso"
			58.0:
				return "Competitivo"
			59.0:
				return "Tematico"
			60.0:
				return "Música"
			61.0:
				return "Artístico"
			62.0:
				return "Habilidad"
			63.0:
				return "Disparos"
			64.0:
				return "Contra jefes"
			65.0:
				return "En solitario"
			66.0:
				return "Superfícies"
			67.0:
				return "Objetos"
			68.0:
				return "Enemigos"
			69.0:
				return "Artilugios"
			70.0:
				return "Traducción"
			71.0:
				return "Para poder publicar el nivel, debes comprobar#que puedes superarlo. ¿Quieres intentarlo ahora?"
			72.0:
				return "Sí"
			73.0:
				return "No"
			74.0:
				return "¡Superalo desde el principio!"
			75.0:
				return "¡Superalo desde el checkpoint!"
			76.0:
				return "Espera unos instantes..."
			77.0:
				return "Publicando..."
			78.0:
				return "¡Genial!"
			79.0:
				return "¡Así No!"
			80.0:
				return "Apariencia"
			81.0:
				return "Entorno"
			82.0:
				return "Autoavance"
			83.0:
				return "Cronometro"
			84.0:
				return "Condicion Especial"
			85.0:
				return "Guardar | Cargar"
			86.0:
				return "Guardar Nivel"
			87.0:
				return "Link"
			88.0:
				return "Nombre del Nivel"
			89.0:
				return "Se procedera a cargar un nivel, se borrarán#todos los elementos colocados hasta ahora.#¿Deseas continuar?"
			90.0:
				return "Nivel Guardado Correctamente"
			91.0:
				return "Tienes un objeto que obstruye el inicio"
			92.0:
				return "No hay elementos para guardar"
			93.0:
				return "El nivel ya existe"
			94.0:
				return "Ingrese el nombre del nivel"
			95.0:
				return "Se han guardado los cambios"
			96.0:
				return "No se puede cargar el nivel"
			97.0:
				return "Sesión iniciada"
			98.0:
				return "No se puede conectar / Actualiza SMM:WE"
			99.0:
				return " No hay conexión a Internet"
			100.0:
				return "Usuario"
			101.0:
				return "Contraseña"
			102.0:
				return "Se ha producido un error"
			103.0:
				return "No se puede leer el nivel"
			104.0:
				return "Guardar#nuevo nivel"
			105.0:
				return "Guardar#cambios"
			106.0:
				return "Cargar"
			107.0:
				return "Cargando..."
			108.0:
				return "Explorar niveles"
			109.0:
				return "Clasificaciones"
			110.0:
				return "Juego Local"
			111.0:
				return "Desafio de Mario Sin Fin"
			112.0:
				return "Prometedores"
			113.0:
				return "Populares"
			114.0:
				return "Novedades"
			115.0:
				return "Busqueda"
			116.0:
				return "IDENTIFICADOR"
			117.0:
				return "ESTILO DEL JUEGO"
			118.0:
				return "TEMA DEL CURSO"
			119.0:
				return "DIFICULTAD"
			120.0:
				return "TIEMPO"
			121.0:
				return "HISTORIAL"
			122.0:
				return "REACCION"
			123.0:
				return "ORDEN"
			124.0:
				return "BUSCAR"
			125.0:
				return "Facil"
			126.0:
				return "Normal"
			127.0:
				return "Dificil"
			128.0:
				return "Experto"
			129.0:
				return "Hoy"
			130.0:
				return "Ultimos 2 dias"
			131.0:
				return "Ultimos 3 dias"
			132.0:
				return "Ultimos 4 dias"
			133.0:
				return "Ultimos 5 dias"
			134.0:
				return "Ultimos 6 dias"
			135.0:
				return "Ultima semana"
			136.0:
				return "Último mes"
			137.0:
				return "Mis superados"
			138.0:
				return "Mis no superados"
			139.0:
				return "Mis gustados"
			140.0:
				return "Mis no gustados"
			141.0:
				return "Novedades"
			142.0:
				return "Mas antiguos"
			143.0:
				return "Descargar"
			144.0:
				return "ID del nivel"
			145.0:
				return "Sin Record"
			146.0:
				return "Victorias"
			147.0:
				return "Cualquiera"
			148.0:
				return "NOMBRE DEL NIVEL"
			149.0:
				return "NOMBRE DEL CREADOR"
			150.0:
				return "Volver a empezar"
			151.0:
				return "Salir"
			152.0:
				return "Continuar"
			153.0:
				return "Reportar"
			154.0:
				return "Nível del agua"
			155.0:
				return "Nível de la lava"
			156.0:
				return "Goma de borrar"
			157.0:
				return "Elige un archivo"
			158.0:
				return "Copiar"
			159.0:
				return "Nueva Partida"
			160.0:
				return "Siguiente"
			161.0:
				return "Salir"
			162.0:
				return "Guardar"
			163.0:
				return "Detalles"
			164.0:
				return "Eliminar"
			165.0:
				return "Sin Condición"
			166.0:
				return "Temas"
			167.0:
				return "FPS"
			168.0:
				return "Pulsa"
			169.0:
				return "Aqui"
			170.0:
				return "Traducciones"
			171.0:
				return "La condición especial ya no puede cumplirse"
			172.0:
				return "Niveles"
			173.0:
				return "Tiempo de conexion agotado"
			174.0:
				return "Error al recuperar los datos"
			175.0:
				return "Hubo un Problema al publicar el nivel"
			176.0:
				return "Copiar y salir"
			177.0:
				return "No se puede publicar este nivel debido a que#utiliza un lenguaje inapropiado"
			178.0:
				return "Nivel descargado"
			179.0:
				return "No se pudo descargar el nivel"
			180.0:
				return "Ocurrio un Error"
			181.0:
				return "Se agrego a prometedores"
			182.0:
				return "Se elimino de prometedores"
			183.0:
				return "Se ha reportado el nivel"
			184.0:
				return "Ya reportaste el nivel"
			185.0:
				return "No puedes reportar tus niveles"
			186.0:
				return "Reintentar"
			187.0:
				return "Configurar los Controles"
			188.0:
				return "Crear una cuenta"
			189.0:
				return "Descripcion"
			190.0:
				return "Sin Descripción"
			191.0:
				return "ETIQUETAS"
			192.0:
				return "Mas Populares"
			193.0:
				return "POPULARIDAD"
			194.0:
				return "IDIOMA"
			195.0:
				return "Menos Populares"
			196.0:
				return "No Prometedor"
			197.0:
				return "Prometedor"
			198.0:
				return "PROMETEDORES"
			199.0:
				return "IDIOMA ETIQUETAS"
			200.0:
				return "Ingrese la descripcion del nivel"
			201.0:
				return "¿Estás seguro de iniciar una nueva partida?#Perderás todo el progreso que hiciste#en el resto de dificultades."
	elif G.idioma == 1.0:
		match argument0:
			0.0:
				return "DISCLAIMER"
			1.0:
				return "This is a fan game (by fans for fans)#which is not endorsed Nintendo.#All images, music and resources used #in this are the owned by Nintendo."
			2.0:
				return "Monday"
			3.0:
				return "Tuesday"
			4.0:
				return "Wednesday"
			5.0:
				return "Thursday"
			6.0:
				return "Friday"
			7.0:
				return "Saturday"
			8.0:
				return "Happy Sunday, let's get making!"
			9.0:
				return "Merry Christmas"
			10.0:
				return "Happy New Year!"
			11.0:
				return "Play"
			12.0:
				return "Course Maker"
			13.0:
				return "Endless Challenge"
			14.0:
				return "Course World"
			15.0:
				return "Coursebot"
			16.0:
				return "English"
			17.0:
				return "USERNAME"
			18.0:
				return "LOG IN"
			19.0:
				return "SETTINGS"
			20.0:
				return "Controls"
			21.0:
				return "Language"
			22.0:
				return "Character"
			23.0:
				return "Sounds"
			24.0:
				return "Window Size"
			25.0:
				return "Special Effects"
			26.0:
				return "Touch Controls"
			27.0:
				return "SM4J Controls"
			28.0:
				return "Ok"
			29.0:
				return "Configure"
			30.0:
				return "Activated"
			31.0:
				return "Deactivated"
			32.0:
				return "Programmers"
			33.0:
				return "Sounds/Music"
			34.0:
				return "Animation and Effects"
			35.0:
				return "Typography"
			36.0:
				return "Additional Contributions"
			37.0:
				return "Special Thanks"
			38.0:
				return "Powered by/Resources"
			39.0:
				return "None"
			40.0:
				return "Slow"
			41.0:
				return "Normal"
			42.0:
				return "Fast"
			43.0:
				return "Actions"
			44.0:
				return "Parts"
			45.0:
				return "Status"
			46.0:
				return "Reach the goal without taking damage"
			47.0:
				return "Reach the goal without landing#after leaving the ground"
			48.0:
				return "Reach the goal without getting out of the water"
			49.0:
				return "Reach the goal without collecting any coin"
			50.0:
				return "Edit"
			51.0:
				return "Upload"
			52.0:
				return "Standard"
			53.0:
				return "Puzzle-solving"
			54.0:
				return "Speedrun"
			55.0:
				return "Autoscroll"
			56.0:
				return "Auto-Mario"
			57.0:
				return "Short and Sweet"
			58.0:
				return "Multiplayer Versus"
			59.0:
				return "Themed"
			60.0:
				return "Music"
			61.0:
				return "Art"
			62.0:
				return "Technical"
			63.0:
				return "Shooter"
			64.0:
				return "Boss battle"
			65.0:
				return "Single player"
			66.0:
				return "Terrain"
			67.0:
				return "Items"
			68.0:
				return "Enemies"
			69.0:
				return "Gizmos"
			70.0:
				return "Translation"
			71.0:
				return "You need to clear your course before uploading it.#Ready to do a clear check?"
			72.0:
				return "Yes"
			73.0:
				return "No"
			74.0:
				return "Clear from the start."
			75.0:
				return "Clear from checkpoint."
			76.0:
				return "Please wait..."
			77.0:
				return "Uploading..."
			78.0:
				return "I like it!"
			79.0:
				return "Boo!"
			80.0:
				return "Game Style"
			81.0:
				return "Game Theme"
			82.0:
				return "Autoscroll"
			83.0:
				return "Timer"
			84.0:
				return "Clear Condition"
			85.0:
				return "Save | Load"
			86.0:
				return "Save Course"
			87.0:
				return "Link"
			88.0:
				return "Course Name"
			89.0:
				return "The course you're currently making will be#lost. Continue?"
			90.0:
				return "Course saved"
			91.0:
				return "You have an object that obstructs the start"
			92.0:
				return "There are no items to save"
			93.0:
				return "This course already exists"
			94.0:
				return "Enter course name"
			95.0:
				return "Changes saved"
			96.0:
				return "Unable to load course"
			97.0:
				return "Logged in"
			98.0:
				return "Can't connect / Update SMM:WE"
			99.0:
				return "There's no internet connection"
			100.0:
				return "Username"
			101.0:
				return "Password"
			102.0:
				return "An error occured"
			103.0:
				return "Unable to read course"
			104.0:
				return "Save As"
			105.0:
				return "Save"
			106.0:
				return "Load"
			107.0:
				return "Loading..."
			108.0:
				return "Courses"
			109.0:
				return "Leaderboards"
			110.0:
				return "Network Play"
			111.0:
				return "Endless Challenge"
			112.0:
				return "Featured"
			113.0:
				return "Popular"
			114.0:
				return "New"
			115.0:
				return "Search"
			116.0:
				return "COURSE ID"
			117.0:
				return "GAME STYLE"
			118.0:
				return "GAME THEME"
			119.0:
				return "DIFFICULTY"
			120.0:
				return "DATE UPLOADED"
			121.0:
				return "CLEAR STATUS"
			122.0:
				return "RATING"
			123.0:
				return "ORDER BY"
			124.0:
				return "SEARCH"
			125.0:
				return "Easy"
			126.0:
				return "Normal"
			127.0:
				return "Expert"
			128.0:
				return "Super Expert"
			129.0:
				return "Today"
			130.0:
				return "Last 2 days"
			131.0:
				return "Last 3 days"
			132.0:
				return "Last 4 days"
			133.0:
				return "Last 5 days"
			134.0:
				return "Last 6 days"
			135.0:
				return "Last week"
			136.0:
				return "Last month"
			137.0:
				return "Cleared"
			138.0:
				return "Not cleared"
			139.0:
				return "Liked"
			140.0:
				return "Boo'ed"
			141.0:
				return "Newest"
			142.0:
				return "Oldest"
			143.0:
				return "Download"
			144.0:
				return "Course ID"
			145.0:
				return "No Record"
			146.0:
				return "Clear Rate"
			147.0:
				return "Any"
			148.0:
				return "COURSE NAME"
			149.0:
				return "MAKER NAME"
			150.0:
				return "Start over"
			151.0:
				return "Quit"
			152.0:
				return "Continue"
			153.0:
				return "Report"
			154.0:
				return "Water Level"
			155.0:
				return "Lava Level"
			156.0:
				return "Erase"
			157.0:
				return "Select a course"
			158.0:
				return "Copy"
			159.0:
				return "New Game"
			160.0:
				return "Next"
			161.0:
				return "Exit Course"
			162.0:
				return "Save"
			163.0:
				return "Details"
			164.0:
				return "Remove"
			165.0:
				return "No Clear Condition"
			166.0:
				return "Theme"
			167.0:
				return "FPS"
			168.0:
				return "Press"
			169.0:
				return "Here"
			170.0:
				return "Translations"
			171.0:
				return "Clear Condition Failed"
			172.0:
				return "Courses"
			173.0:
				return "Connection timed out"
			174.0:
				return "Error retrieving data"
			175.0:
				return "Couldn't upload the level"
			176.0:
				return "Copy and exit"
			177.0:
				return "Unable to upload this course because#it uses inappropriate language"
			178.0:
				return "Level downloaded"
			179.0:
				return "Couldn't download the level"
			180.0:
				return "An error occurred"
			181.0:
				return "Added to featured"
			182.0:
				return "Deleted from featured"
			183.0:
				return "The course has been reported"
			184.0:
				return "You already reported the course"
			185.0:
				return "You can't report your courses"
			186.0:
				return "Retry"
			187.0:
				return "Configure Controls"
			188.0:
				return "Create an account"
			189.0:
				return "Description"
			190.0:
				return "No Description"
			191.0:
				return "Tags"
			192.0:
				return "Most Popular"
			193.0:
				return "POPULARITY"
			194.0:
				return "LANGUAGE"
			195.0:
				return "Least Popular"
			196.0:
				return "Not Featured"
			197.0:
				return "Featured"
			198.0:
				return "FEATURED"
			199.0:
				return "TAGS LANGUAGE"
			200.0:
				return "Enter course description"
			201.0:
				return "Are you sure to start a new game?#You will lose all the progress you made#in the rest of the difficulties."
	elif G.idioma == 2.0:
		match argument0:
			0.0:
				return "AVISO!"
			1.0:
				return "Este é um 'Fã Game' (de fãs para fãs)#por isso não é endossado pela Nintendo.#Todas as imagens, músicas e recursos usados#são propriedades da Nintendo."
			2.0:
				return "Segunda-feira"
			3.0:
				return "Terça-feira"
			4.0:
				return "Quarta-feira"
			5.0:
				return "Quinta-feira"
			6.0:
				return "Sexta-feira"
			7.0:
				return "Sábado"
			8.0:
				return "Já é domingo, vamos fazer níveis!"
			9.0:
				return "Feliz Natal"
			10.0:
				return "Feliz Ano Novo"
			11.0:
				return "Jogar"
			12.0:
				return "Criar um nível"
			13.0:
				return "Desafio Super Mario"
			14.0:
				return "Níveis Mundiais"
			15.0:
				return "Guardabot"
			16.0:
				return "Português"
			17.0:
				return "NOME DE USUÁRIO"
			18.0:
				return "INICIAR SESSÃO"
			19.0:
				return "Configurações"
			20.0:
				return "Controles"
			21.0:
				return "Idioma"
			22.0:
				return "Personagem"
			23.0:
				return "Sons"
			24.0:
				return "Janela"
			25.0:
				return "Efeitos Especiais"
			26.0:
				return "Controles de toque"
			27.0:
				return "Controles SM4J"
			28.0:
				return "Aceitar"
			29.0:
				return "Configurar"
			30.0:
				return "Ativado"
			31.0:
				return "Desativado"
			32.0:
				return "Programadores"
			33.0:
				return "Som/Música"
			34.0:
				return "Animação e efeitos"
			35.0:
				return "Fonte"
			36.0:
				return "Contribuições Adicionais"
			37.0:
				return "Agradecimentos especiais"
			38.0:
				return "Power by/Recursos"
			39.0:
				return "Nenhum"
			40.0:
				return "Lento"
			41.0:
				return "Normal"
			42.0:
				return "Rápido"
			43.0:
				return "Ações"
			44.0:
				return "Elementos"
			45.0:
				return "Estado"
			46.0:
				return "Alcance a meta sem sofrer dano"
			47.0:
				return "Alcance a meta sem tocar o chão depois#de separar os pés dela"
			48.0:
				return "Alcance a meta sem sair da água"
			49.0:
				return "Alcance a meta sem coletar nenhuma moeda"
			50.0:
				return "Editar"
			51.0:
				return "Publicar"
			52.0:
				return "Tradicional"
			53.0:
				return "Puzzles"
			54.0:
				return "Contra-relógio"
			55.0:
				return "Avanço automático"
			56.0:
				return "Automáticos"
			57.0:
				return "Curto porém intenso"
			58.0:
				return "Competitivo"
			59.0:
				return "Temático"
			60.0:
				return "Música"
			61.0:
				return "Artístico"
			62.0:
				return "Habilidade"
			63.0:
				return "Disparos"
			64.0:
				return "Contra chefes"
			65.0:
				return "Sozinho"
			66.0:
				return "Superfícies"
			67.0:
				return "Objetos"
			68.0:
				return "Inimigos"
			69.0:
				return "Aparelhos"
			70.0:
				return "Tradução"
			71.0:
				return "Para publicar o nível, você deve provar que pode vencê-lo.# Quer experimentar agora?"
			72.0:
				return "Sim"
			73.0:
				return "Não"
			74.0:
				return "Supere desde o início!"
			75.0:
				return "Supere desde do checkpoint!"
			76.0:
				return "Aguarde alguns instantes..."
			77.0:
				return "Publicando..."
			78.0:
				return "Incrível!"
			79.0:
				return "Assim não!"
			80.0:
				return "Aparência"
			81.0:
				return "Ambiente"
			82.0:
				return "Avanço automático"
			83.0:
				return "Cronômetro"
			84.0:
				return "Condição especial"
			85.0:
				return "Salvar | Carregar"
			86.0:
				return "Salvar Nível"
			87.0:
				return "Link"
			88.0:
				return "Nome do nível"
			89.0:
				return "Um nível será carregado, todos os elementos#colocados até agora serão excluídos.#Deseja continuar?"
			90.0:
				return "Nível salvo com sucesso"
			91.0:
				return "Você tem um objeto que obstrui o início"
			92.0:
				return "Não há itens para salvar"
			93.0:
				return "O nível já existe"
			94.0:
				return "Digite o nome do nível"
			95.0:
				return "As mudanças foram salvas"
			96.0:
				return "Não é possível carregar o nível"
			97.0:
				return "Sessão iniciada"
			98.0:
				return "Falha ao fazer login"
			99.0:
				return " Não há conexão com a Internet"
			100.0:
				return "Usuário"
			101.0:
				return "Senha"
			102.0:
				return "Um erro ocorreu"
			103.0:
				return "O nível não pode ser lido"
			104.0:
				return "Salvar#novo nível"
			105.0:
				return "Salvar#mudança"
			106.0:
				return "Carregar"
			107.0:
				return "Carregando..."
			108.0:
				return "Explorar níveis"
			109.0:
				return "Classificações"
			110.0:
				return "Jogo local"
			111.0:
				return "Desafio Mario Sem Fim"
			112.0:
				return "Promissores"
			113.0:
				return "Populares"
			114.0:
				return "Novidades"
			115.0:
				return "Procurar"
			116.0:
				return "IDENTIFICADOR"
			117.0:
				return "ESTILO DE JOGO"
			118.0:
				return "TEMA DO CURSOR"
			119.0:
				return "DIFICULDADE"
			120.0:
				return "TEMPO"
			121.0:
				return "REGISTRO"
			122.0:
				return "REAÇÃO"
			123.0:
				return "ORDEM"
			124.0:
				return "BUSCAR"
			125.0:
				return "Fácil"
			126.0:
				return "Normal"
			127.0:
				return "Difícil"
			128.0:
				return "Super Difícil"
			129.0:
				return "Hoje"
			130.0:
				return "Últimos 2 dias"
			131.0:
				return "Últimos 3 dias"
			132.0:
				return "Últimos 4 dias"
			133.0:
				return "Últimos 5 dias"
			134.0:
				return "Últimos 6 dias"
			135.0:
				return "Semana anterior"
			136.0:
				return "Último mês"
			137.0:
				return "Meus superados"
			138.0:
				return "Meus não superados"
			139.0:
				return "Meus favoritos"
			140.0:
				return "Meus não favoritos"
			141.0:
				return "Novidades"
			142.0:
				return "Mais antigos"
			143.0:
				return "Download"
			144.0:
				return "ID do nível"
			145.0:
				return "Sem Recordes"
			146.0:
				return "Vitórias"
			147.0:
				return "Qualquer um"
			148.0:
				return "NOME DO NIVEL"
			149.0:
				return "NOME DO CRIADOR"
			150.0:
				return "Começar de novo"
			151.0:
				return "Sair"
			152.0:
				return "Continuar"
			153.0:
				return "Reportar"
			154.0:
				return "Nível da água"
			155.0:
				return "Nível da lava"
			156.0:
				return "Borracha"
			157.0:
				return "Escolha um arquivo"
			158.0:
				return "Copiar"
			159.0:
				return "Nova Partida"
			160.0:
				return "Seguinte"
			161.0:
				return "Sair"
			162.0:
				return "Salvar"
			163.0:
				return "Detalhes"
			164.0:
				return "Eliminar"
			165.0:
				return "Sem Condição"
			166.0:
				return "Temas"
			167.0:
				return "FPS"
			168.0:
				return "Pressione"
			169.0:
				return "Aqui"
			170.0:
				return "Traduções"
			171.0:
				return "A condição especial não pode mais ser atendida"
			172.0:
				return "Niveis"
			173.0:
				return "Conexão expirou"
			174.0:
				return "Erro ao recuperar dados"
			175.0:
				return "Ocorreu um problema ao publicar o nível"
			176.0:
				return "Copiar e sair"
			177.0:
				return "Não é possível publicar este nível porque#ele usa linguagem imprópria"
			178.0:
				return "Nivel baixado"
			179.0:
				return "Não foi possível baixar o nível"
			180.0:
				return "Ocorreu um erro"
			181.0:
				return "Adicionado ao promissores"
			182.0:
				return "Eliminado de promissores"
			183.0:
				return "O nivel foi reportado"
			184.0:
				return "Voce ja relatou o nivel"
			185.0:
				return "Você não pode relatar seus níveis"
			186.0:
				return "Repetir"
			187.0:
				return "Configurar Controles"
			188.0:
				return "Criar uma conta"
			189.0:
				return "Descrição"
			190.0:
				return "Sem Descrição"
			191.0:
				return "Rótulos"
			192.0:
				return "Mais Populares"
			193.0:
				return "POPULARIDADE"
			194.0:
				return "IDIOMA"
			195.0:
				return "Menos Populares"
			196.0:
				return "Nao Promissor"
			197.0:
				return "Promissor"
			198.0:
				return "PROMISSORES"
			199.0:
				return "IDIOMA ROTULOS"
			200.0:
				return "Digite o descrição do nível"
			201.0:
				return "Tem certeza de que quer iniciar uma nova partida?#Você perdera todo o progresso q fez#no resto das dificuldades."
	elif G.idioma == 3.0:
		match argument0:
			0.0:
				return "ATTENZIONE!"
			1.0:
				return "Questo è un 'Fan Game' (dai fan per i fan)#quindi non è approvato da Nintendo.#Tutte le immagini, la musica e le risorse utilizzate# sono di proprietà di Nintendo."
			2.0:
				return "Lunedì"
			3.0:
				return "Martedì"
			4.0:
				return "Mercoledì"
			5.0:
				return "Giovedì"
			6.0:
				return "Venerdì"
			7.0:
				return "Sabato"
			8.0:
				return "È già Domenica, facciamo i livelli!"
			9.0:
				return "Buon Natale <3"
			10.0:
				return "Felice Anno Nuovo!"
			11.0:
				return "Gioca"
			12.0:
				return "Crea un livello"
			13.0:
				return "Sfida Super Mario"
			14.0:
				return "Livelli Dal Mondo"
			15.0:
				return "Memobot"
			16.0:
				return "Italiano"
			17.0:
				return "NOME UTENTE"
			18.0:
				return "ACCEDI"
			19.0:
				return "IMPOSTAZIONI"
			20.0:
				return "Controlli"
			21.0:
				return "Lingua"
			22.0:
				return "Personaggi"
			23.0:
				return "Suoni"
			24.0:
				return "Schermo"
			25.0:
				return "Effetti speciali"
			26.0:
				return "Controlli touch"
			27.0:
				return "Controlli SM4J"
			28.0:
				return "OK"
			29.0:
				return "Configura"
			30.0:
				return "Abilitato"
			31.0:
				return "Disabilitato"
			32.0:
				return "Programmatori"
			33.0:
				return "Suono/Musica"
			34.0:
				return "Animazione ed effetti"
			35.0:
				return "Carattere tipografico"
			36.0:
				return "Contributi Aggiuntivi"
			37.0:
				return "Ringraziamenti speciali"
			38.0:
				return "Power by/Risorse"
			39.0:
				return "Nessuno"
			40.0:
				return "Lento"
			41.0:
				return "Normale"
			42.0:
				return "Veloce"
			43.0:
				return "Azioni"
			44.0:
				return "Elementi"
			45.0:
				return "Stato"
			46.0:
				return "Raggiungi il traguardo senza subire danni"
			47.0:
				return "Raggiungi il traguardo senza toccare terra#dopo un salto"
			48.0:
				return "Raggiungi il traguardo senza lasciare l'acqua"
			49.0:
				return "Raggiungi il traguardo senza raccogliere monete"
			50.0:
				return "Modifica"
			51.0:
				return "Pubblica"
			52.0:
				return "Classico"
			53.0:
				return "Rompicapi"
			54.0:
				return "Corsa"
			55.0:
				return "Scorrimento"
			56.0:
				return "Automatico"
			57.0:
				return "Corto ma bello"
			58.0:
				return "Competizione"
			59.0:
				return "Tematico"
			60.0:
				return "Musica"
			61.0:
				return "Artistico"
			62.0:
				return "Tecnico"
			63.0:
				return "Sparatutto"
			64.0:
				return "Scontro col boss"
			65.0:
				return "Un giocatore"
			66.0:
				return "Terreno"
			67.0:
				return "Oggetti"
			68.0:
				return "Nemici"
			69.0:
				return "Dispositivi"
			70.0:
				return "Traduzione"
			71.0:
				return "Devi superare il livello prima di poterlo pubblicare.#Vuoi provare a superarlo?"
			72.0:
				return "Sì"
			73.0:
				return "No"
			74.0:
				return "Superalo dall'inizio!"
			75.0:
				return "Superalo dal checkpoint!"
			76.0:
				return "Aspetta qualche istante..."
			77.0:
				return "Pubblicazione..."
			78.0:
				return "Bello"
			79.0:
				return "Mah..."
			80.0:
				return "Stile"
			81.0:
				return "Tema"
			82.0:
				return "Scorrimento automatico"
			83.0:
				return "Orologio"
			84.0:
				return "Condizione Speciale"
			85.0:
				return "Salva | Carica"
			86.0:
				return "Salva livello"
			87.0:
				return "Link"
			88.0:
				return "Nome del livello"
			89.0:
				return "Verrà caricato un livello, #tutti gli elementi posizionati finora verranno cancellati.#Vuoi continuare?"
			90.0:
				return "Livello salvato con successo"
			91.0:
				return "Hai un oggetto che ostruisce l'inizio"
			92.0:
				return "Nessun elemento da salvare"
			93.0:
				return "Il livello esiste già"
			94.0:
				return "Inserisci il nome del livello"
			95.0:
				return "Le modifiche sono state salvate"
			96.0:
				return "Impossibile caricare il livello"
			97.0:
				return "Sessione iniziata"
			98.0:
				return "Accesso non riuscito"
			99.0:
				return "Nessuna connessione Internet"
			100.0:
				return "Utente"
			101.0:
				return "Password"
			102.0:
				return "Si è verificato un errore"
			103.0:
				return "Impossibile leggere il livello"
			104.0:
				return "Salva#nuovo livello"
			105.0:
				return "Salva#modifiche"
			106.0:
				return "Carica"
			107.0:
				return "Caricamento in corso..."
			108.0:
				return "Esplora livelli"
			109.0:
				return "Classifica"
			110.0:
				return "Partita locale"
			111.0:
				return "Sfida Infinita"
			112.0:
				return "Promettenti"
			113.0:
				return "Popolari"
			114.0:
				return "Nuovi"
			115.0:
				return "Ricerca dettagliata"
			116.0:
				return "IDENTIFICATORE"
			117.0:
				return "STILE"
			118.0:
				return "TEMA"
			119.0:
				return "DIFFICOLTÀ"
			120.0:
				return "TEMPO"
			121.0:
				return "STORIA"
			122.0:
				return "REAZIONI"
			123.0:
				return "ORDINE"
			124.0:
				return "CERCA"
			125.0:
				return "Facile"
			126.0:
				return "Normale"
			127.0:
				return "Difficile"
			128.0:
				return "Super difficile"
			129.0:
				return "Oggi"
			130.0:
				return "Ultimi 2 giorni"
			131.0:
				return "Ultimi 3 giorni"
			132.0:
				return "Ultimi 4 giorni"
			133.0:
				return "Ultimi 5 giorni"
			134.0:
				return "Ultimi 6 giorni"
			135.0:
				return "La scorsa settimana"
			136.0:
				return "Ultimo mese"
			137.0:
				return "I miei superati"
			138.0:
				return "I miei fallimenti"
			139.0:
				return "Mi piace"
			140.0:
				return "Non mi piace"
			141.0:
				return "Più nuovi"
			142.0:
				return "Più vecchi"
			143.0:
				return "Scarica"
			144.0:
				return "ID livello"
			145.0:
				return "Nessun record"
			146.0:
				return "Vittoria"
			147.0:
				return "Qualsiasi"
			148.0:
				return "NOME LIVELLO"
			149.0:
				return "NOME CREATORE"
			150.0:
				return "Ricomincia da capo"
			151.0:
				return "Esci"
			152.0:
				return "Continua"
			153.0:
				return "Segnala"
			154.0:
				return "Livello dell'acqua"
			155.0:
				return "Livello della lava"
			156.0:
				return "Gomma"
			157.0:
				return "Scegli un file"
			158.0:
				return "Copia"
			159.0:
				return "Nuova partita"
			160.0:
				return "Avanti"
			161.0:
				return "Esci"
			162.0:
				return "Salva"
			163.0:
				return "Dettagli"
			164.0:
				return "Elimina"
			165.0:
				return "Nessuna condizione"
			166.0:
				return "Temi"
			167.0:
				return "FPS"
			168.0:
				return "Premi"
			169.0:
				return "Qua"
			170.0:
				return "Traduzioni"
			171.0:
				return "La condizione speciale non può essere soddisfatta"
			172.0:
				return "Livelli"
			173.0:
				return "Connessione scaduta"
			174.0:
				return "Errore durante il recupero dei dati"
			175.0:
				return "Si è verificato un problema durante la pubblicazione del livello"
			176.0:
				return "Copia ed esci"
			177.0:
				return "Impossibile pubblicare questo livello perché # utilizza un linguaggio inappropriato"
			178.0:
				return "Livello scaricato"
			179.0:
				return "Impossibile scaricare il livello"
			180.0:
				return "Si è verificato un errore"
			181.0:
				return "Aggiunto ai promettenti"
			182.0:
				return "Rimosso dai promettenti"
			183.0:
				return "Il livello è stato segnalato"
			184.0:
				return "Hai già segnalato il livello"
			185.0:
				return "Non puoi segnalare i tuoi livelli"
			186.0:
				return "Riprova"
			187.0:
				return "Configura i controlli"
			188.0:
				return "Crea un account"
			189.0:
				return "Descrizione"
			190.0:
				return "Nessuna descrizione"
			191.0:
				return "Etichette"
			192.0:
				return "Più Popolari"
			193.0:
				return "POPOLARITA'"
			194.0:
				return "LINGUA"
			195.0:
				return "Meno Popolari"
			196.0:
				return "Non Promettente"
			197.0:
				return "Promettente"
			198.0:
				return "PROMETTENTI"
			199.0:
				return "LINGUA ETICHETTE"
			200.0:
				return "Inserisci la descrizione del livello"
			201.0:
				return "Sei sicuro di iniziare una nuova partita?#Perderai tutti i progressi fatti#nelle altre difficoltà."
	elif G.idioma == 4.0:
		match argument0:
			0.0:
				return "免责声明"
			1.0:
				return "本游戏为同人游戏，#未经任天堂许可，#其中的图像、声音等资源#版权归任天堂所有。"
			2.0:
				return "星期一"
			3.0:
				return "星期二"
			4.0:
				return "星期三"
			5.0:
				return "星期四"
			6.0:
				return "星期五"
			7.0:
				return "星期六"
			8.0:
				return "今天是星期日，一起来制造吧！"
			9.0:
				return "圣诞快乐！"
			10.0:
				return "新年快乐！"
			11.0:
				return "游玩"
			12.0:
				return "创作关卡"
			13.0:
				return "马力欧耐力挑战"
			14.0:
				return "全球关卡"
			15.0:
				return "关卡机器人"
			16.0:
				return "简体中文"
			17.0:
				return "用户名"
			18.0:
				return "登录"
			19.0:
				return "选项"
			20.0:
				return "控制"
			21.0:
				return "语言"
			22.0:
				return "人物"
			23.0:
				return "音量"
			24.0:
				return "窗口大小"
			25.0:
				return "特效"
			26.0:
				return "虚拟案件"
			27.0:
				return "经典操作模式"
			28.0:
				return "OK"
			29.0:
				return "设置"
			30.0:
				return "启用"
			31.0:
				return "禁用"
			32.0:
				return "程序员"
			33.0:
				return "音乐和音效"
			34.0:
				return "动画和动效"
			35.0:
				return "字体"
			36.0:
				return "其他贡献者"
			37.0:
				return "特别感谢"
			38.0:
				return "引擎和资源"
			39.0:
				return "无"
			40.0:
				return "慢速"
			41.0:
				return "中等"
			42.0:
				return "快速"
			43.0:
				return "操作"
			44.0:
				return "零件"
			45.0:
				return "状态"
			46.0:
				return "在1次也没有受到伤害的状态下通过终点"
			47.0:
				return "在离开地面后不着地的状态下通过终点"
			48.0:
				return "没有离开过水面而通过终点"
			49.0:
				return "不收集任何金币而通过终点"
			50.0:
				return "编辑"
			51.0:
				return "发布"
			52.0:
				return "标准"
			53.0:
				return "解谜"
			54.0:
				return "计时挑战"
			55.0:
				return "自动卷轴"
			56.0:
				return "自动马力欧"
			57.0:
				return "一次通过"
			58.0:
				return "多人对战"
			59.0:
				return "机关设计"
			60.0:
				return "音乐"
			61.0:
				return "美术"
			62.0:
				return "技巧"
			63.0:
				return "射击"
			64.0:
				return "对战BOSS"
			65.0:
				return "单打"
			66.0:
				return "地形"
			67.0:
				return "道具"
			68.0:
				return "敌人"
			69.0:
				return "机关"
			70.0:
				return "翻译"
			71.0:
				return "如果不通关，就无法发表。#要进行过关确认吗？"
			72.0:
				return "是"
			73.0:
				return "否"
			74.0:
				return "从起始地点确认！"
			75.0:
				return "从中间点确认！"
			76.0:
				return "请稍后..."
			77.0:
				return "正在发布..."
			78.0:
				return "赞!"
			79.0:
				return "不好!"
			80.0:
				return "游戏风格"
			81.0:
				return "场景类型"
			82.0:
				return "自动卷轴"
			83.0:
				return "计时器"
			84.0:
				return "终点条件"
			85.0:
				return "保存 | 读取"
			86.0:
				return "保存关卡"
			87.0:
				return "林克"
			88.0:
				return "关卡的名字"
			89.0:
				return "如果读取关卡，放置的零件将全部消失。#确定要进行吗？"
			90.0:
				return "关卡已保存。"
			91.0:
				return "无法保存关卡。"
			92.0:
				return "无法保存空白关卡。"
			93.0:
				return "关卡已经存在。"
			94.0:
				return "请输入关卡名"
			95.0:
				return "更改已保存。"
			96.0:
				return "无法载入关卡。"
			97.0:
				return "登录成功。"
			98.0:
				return "登录失败。"
			99.0:
				return "无互联网连接。"
			100.0:
				return "用户名"
			101.0:
				return "密码"
			102.0:
				return "发生错误。"
			103.0:
				return "无法读取关卡。"
			104.0:
				return "另存为"
			105.0:
				return "保存"
			106.0:
				return "读取"
			107.0:
				return "正在读取..."
			108.0:
				return "关卡"
			109.0:
				return "分类"
			110.0:
				return "多人对战"
			111.0:
				return "马力欧耐力挑战"
			112.0:
				return "期待的关卡"
			113.0:
				return "受欢迎的"
			114.0:
				return "新关卡"
			115.0:
				return "搜索"
			116.0:
				return "关卡 ID"
			117.0:
				return "游戏风格"
			118.0:
				return "场景类型"
			119.0:
				return "难度"
			120.0:
				return "发表日"
			121.0:
				return "过关状态"
			122.0:
				return "我的评价"
			123.0:
				return "排序"
			124.0:
				return "搜索"
			125.0:
				return "简单"
			126.0:
				return "普通"
			127.0:
				return "困难"
			128.0:
				return "极难"
			129.0:
				return "今天"
			130.0:
				return "过去 2 天"
			131.0:
				return "过去 3 天"
			132.0:
				return "过去 4 天"
			133.0:
				return "过去 5 天"
			134.0:
				return "过去 6 天"
			135.0:
				return "上一周"
			136.0:
				return "上个月"
			137.0:
				return "已过关"
			138.0:
				return "未过关"
			139.0:
				return "点过 '赞'"
			140.0:
				return "点过 '不好'"
			141.0:
				return "正序"
			142.0:
				return "倒序"
			143.0:
				return "下载"
			144.0:
				return "关卡 ID"
			145.0:
				return "没有人过关"
			146.0:
				return "过关率"
			147.0:
				return "任意"
			148.0:
				return "关卡名"
			149.0:
				return "工匠名"
			150.0:
				return "重新开始"
			151.0:
				return "离开关卡"
			152.0:
				return "继续"
			153.0:
				return "举报"
			154.0:
				return "水面的高度"
			155.0:
				return "熔岩的高度"
			156.0:
				return "橡皮擦"
			157.0:
				return "选择关卡"
			158.0:
				return "复制"
			159.0:
				return "新游戏"
			160.0:
				return "继续"
			161.0:
				return "离开关卡"
			162.0:
				return "保存"
			163.0:
				return "详情"
			164.0:
				return "删除"
			165.0:
				return "没有终点条件"
			166.0:
				return "场景类型"
			167.0:
				return "FPS"
			168.0:
				return "点击"
			169.0:
				return "此处"
			170.0:
				return "翻译"
			171.0:
				return "无法达成终点条件。"
			172.0:
				return "关卡"
			173.0:
				return "连接超时。"
			174.0:
				return "连接中止。"
			175.0:
				return "无法发布关卡。"
			176.0:
				return "复制并返回"
			177.0:
				return "无法发布这个关卡，#因为使用了不恰当的用语。"
			178.0:
				return "关卡已下载。"
			179.0:
				return "无法下载关卡。"
			180.0:
				return "发生错误。"
			181.0:
				return "已加入“期待的关卡”。"
			182.0:
				return "已从“期待的关卡”中删除。"
			183.0:
				return "关卡已举报。"
			184.0:
				return "你已经举报过这个关卡了。"
			185.0:
				return "你不能举报自己的关卡。"
			186.0:
				return "重试"
			187.0:
				return "设置按键"
			188.0:
				return "注册账号"
			189.0:
				return "关卡说明"
			190.0:
				return "没有描述"
			191.0:
				return "标签"
			192.0:
				return "更流行"
			193.0:
				return "人气"
			194.0:
				return "舌头"
			195.0:
				return "不太受欢迎"
			196.0:
				return "没有希望"
			197.0:
				return "没有特色"
			198.0:
				return "精选"
			199.0:
				return "语言标签"
			200.0:
				return "输入关卡描述"
			201.0:
				return "您确定要开始新游戏吗？#你将失去在其他困难上取得的所有进展。"
	return null  # GML 走到结尾返回 undefined
