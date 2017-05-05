local composer =  require("composer") 

local calculadora = composer.newScene()

local widget = require("widget")

local String = require("string")

conta, operacao, numero1 = "", "", ""
sound = 1

local sound0 = audio.loadSound( "audios/0.wav" )
local sound1 = audio.loadSound( "audios/1.wav" )
local sound2 = audio.loadSound( "audios/2.wav" )
local sound3 = audio.loadSound( "audios/3.wav" )
local sound4 = audio.loadSound( "audios/4.wav" )
local sound5 = audio.loadSound( "audios/5.wav" )
local sound6 = audio.loadSound( "audios/6.wav" )
local sound7 = audio.loadSound( "audios/7.wav" )
local sound8 = audio.loadSound( "audios/8.wav" )
local sound9 = audio.loadSound( "audios/9.wav" )

local soundSoma = audio.loadSound( "audios/mais.wav" )
local soundSubt = audio.loadSound( "audios/menos.wav" )
local soundMult = audio.loadSound( "audios/vezes.wav" )
local soundDiv = audio.loadSound( "audios/dividido.wav" )
local soundPonto = audio.loadSound( "audios/ponto.wav" )

local soundVezes_1 = audio.loadSound("audios/vezes_-1.wav")
local soundApagarUltimoC = audio.loadSound("audios/apagar_ultimo_caracter.wav")
local soundPorcentode = audio.loadSound("audios/porcento_de.wav")
local soundLimparTudo = audio.loadSound("audios/limpar_tudo.wav")
local soundIguala = audio.loadSound("audios/igual_a.wav")


local function playAudio(num)
    if (sound == 1) then
        if (num == 0 or num == "0") then
            audio.play( sound0 )
        elseif (num == 1  or num == "1") then
            audio.play( sound1 )
        elseif (num == 2  or num == "2") then
            audio.play( sound2 )
        elseif (num == 3  or num == "3") then
            audio.play( sound3 )
        elseif (num == 4  or num == "4") then
            audio.play( sound4 )
        elseif (num == 5  or num == "5") then
            audio.play( sound5 )
        elseif (num == 6  or num == "6") then
            audio.play( sound6 )
        elseif (num == 7  or num == "7") then
            audio.play( sound7 )
        elseif (num == 8  or num == "8") then
            audio.play( sound8 )
        elseif (num == 9  or num == "9") then
            audio.play( sound9 )
        elseif (num == "=") then
            audio.play(soundIguala)
        elseif (num == "C") then
            audio.play(soundLimparTudo)
        elseif (num == ".") then
            audio.play( soundPonto )
        elseif (num == "/") then
            audio.play( soundDiv )
        elseif (num == "x") then
            audio.play(soundMult)
        elseif (num == "-") then
            audio.play( soundSubt )
        elseif (num == "+") then
            audio.play( soundSoma )
        elseif (num == "%") then
            audio.play(soundPorcentode)
        elseif (num == "-1") then
            audio.play(soundVezes_1)
        elseif (num == "del") then
            audio.play(soundApagarUltimoC)
        end
    end
end

local function valida(numero)
    if (operacao ~= "") and (numero1 == "") then
        numero1 = tonumber(conta)
        conta = numero
        visor.text = conta
    elseif (operacao ~= "") and (numero1 ~= "") then   
        conta = conta..numero
        visor.text = conta
    elseif (operacao == "") then
        conta = conta..numero
        visor.text = conta
    end
end

function wait(seconds)
  local start = os.time()
  repeat until os.time() > start + seconds
end

function audioResultado( numero )
    for i = 1, String.len(numero), 1  do
        num = string.sub(numero, i, i)
        wait(1)
        playAudio(num)
    end
end

local function buttonCalcula(event)

    if (event.phase == "ended") then
        if (numero1 ~= "") then
            numero1 = tonumber(numero1)
            conta = tonumber(conta)
            
            if (operacao == "soma") then
                conta = (numero1 + conta)
            elseif (operacao == "subtracao") then
                conta = (numero1 - conta)
            elseif (operacao == "multiplicacao") then
                conta = (numero1 * conta)
            elseif (operacao == "divisao") then
                conta = (numero1 / conta)
            elseif (operacao == "percentual") then
                conta = ((numero1/100) * conta)
            end

            operacao, numero1 = "", ""
            visor.text = conta
            playAudio("=")        
            if (sound == 1) then
                audioResultado(conta)
            end   
        end
    end
end

local function buttonCalcular()
    numero1 = tonumber(numero1)
    conta = tonumber(conta)
    
    if (operacao == "soma") then
        conta = (numero1 + conta)
    elseif (operacao == "subtracao") then
        conta = (numero1 - conta)
    elseif (operacao == "multiplicacao") then
        conta = (numero1 * conta)
    elseif (operacao == "divisao") then
        conta = (numero1 / conta)
    elseif (operacao == "percentual") then
        conta = ((numero1/100) * conta)
    end

    operacao, numero1 = "", ""
    visor.text = conta  
end

local function buttonC(event)
    if ( "ended" == event.phase ) then
        playAudio("C")
        conta, numero1, operacao = "", "", ""
        visor.text = conta
    end
end

local function numericButton(event)   
    if ( "ended" == event.phase ) then  

        valida(event.target.id)
        if (sound == 1) then
            playAudio(event.target.id)
        end
    end
end

local function buttonPonto(event)  
    if ( "ended" == event.phase ) then
        if (string.find(conta, '%.') == nil) then
            conta = conta.."."
            playAudio(".")
            visor.text = conta
        end

    end
end

local function buttonOperacao( event)
    if ( "ended" == event.phase ) then
        if ((operacao ~= "") and (numero1 ~= ""))then
            buttonCalcular()
        end
        if (String.len(conta) >= 1) then
            if (visor.text ~= "") then
                if (event.target.id == "/") then
                    operacao = "divisao"
                elseif (event.target.id == "x") then
                    operacao = "multiplicacao"
                elseif (event.target.id == "-") then
                    operacao = "subtracao"                    
                elseif (event.target.id == "+") then
                    operacao = "soma"
                end

                playAudio(event.target.id)
            end
        end
    end
end

local function buttonPerc(event)  
    if ( "ended" == event.phase ) then
        if (String.len(conta) >= 1) then

            if (operacao ~= "") then
                buttonCalcula()
            end
            
            operacao = "percentual"            
            playAudio("%")
        end
    end
end

local function buttonOposto(event)   
    if ( "ended" == event.phase ) then
        if (String.len(conta) >= 1) then
            playAudio("-1")
            conta = conta * -1
            visor.text = conta
        end
    end
end

local function buttonDel( event )
    if ( "ended" == event.phase ) then
        if (String.len(conta) >= 1) then
            playAudio("del")
            conta = string.sub(conta, 1, string.len(conta)-1)
            visor.text = conta
        end
    end
end

function creatButton ()
    mLeft = 0
    mSuperior = 444
    for i=0, 9, 1 do 
        if ((i == 7) or (i == 4) or (i == 1) or (i == 0))then
            mLeft = 0
        elseif ((i ~= 7) or (i ~= 4) or (i ~= 1) or (i ~= 0)) then
            mLeft = mLeft + 80
        end

        if ((i == 7) or (i == 4) or (i == 1))then
            mSuperior = mSuperior - 80
        end        

        local btn = widget.newButton({
            left = mLeft,
            top = mSuperior,   
            label = i,
            fontSize = 30,
            shape = "roundedRect",
            width = 80,
            height = 80,
            cornerRadius = 0,
            fillColor = { default={1,1,1,0.7}, over={1,1,1,0.5} },
            strokeColor = { default={0.9,0.9,0.9,1}, over={0.8,0.8,0.8,1} },
            strokeWidth = 1,
            id = i,
            onEvent = numericButton  
        })
    end

    label = {"/", "x", "-", "+", "%"}
    mSuperior = 204
    for i=1, 5, 1 do   
        local btn = widget.newButton({
            left = 240,
            top = mSuperior,   
            label = label[i],
            fontSize = 30,
            shape = "roundedRect",
            width = 79,
            height = 80,
            cornerRadius = 0,
            fillColor = { default={0.9,0.9,0.9,1}, over={0.8,0.8,0.8,1} },
            strokeColor = { default={0.8,0.8,0.8,1}, over={0.8,0.8,0.8,1} },
            strokeWidth = 1,
            id = label[i],
            onEvent = buttonOperacao 
        })

        mSuperior = mSuperior + 80
    end

    local btnPonto = widget.newButton({
            left = 80,
            top = 444,   
            label = ".",
            fontSize = 30,
            shape = "roundedRect",
            width = 80,
            height = 80,
            cornerRadius = 0,
            fillColor = { default={1,1,1,0.7}, over={1,1,1,0.5} },
            strokeColor = { default={0.9,0.9,0.9,1}, over={0.8,0.8,0.8,1} },
            strokeWidth = 1,
            onEvent = buttonPonto         
    })

    local btnCalcula = widget.newButton({
            left = 160,
            top = 444,   
            label = "=",
            fontSize = 30,
            shape = "roundedRect",
            width = 79,
            height = 80,
            cornerRadius = 0,
            fillColor = { default={0.9,0.6,0,1}, over={0.9,0.6,0,0.7} },
            strokeColor = { default={0.2,0.2,0.3,0.4}, over={0.8,0.8,1,1} },
            labelColor = { default={ 1, 1, 1 }, over={ 0, 0, 0, 0.5 } },
            strokeWidth = 1,
            onEvent = buttonCalcula
            
    })

    local btnC = widget.newButton({
            left = 0,
            top = 124,   
            label = "C",
            fontSize = 30,
            shape = "roundedRect",
            width = 80,
            height = 80,
            cornerRadius = 0,
            fillColor = { default={1,1,1,0.7}, over={1,1,1,0.5} },
            strokeColor = { default={0.9,0.9,0.9,1}, over={0.8,0.8,0.8,1} },
            strokeWidth = 1,
            onEvent = buttonC      
    })

    local btnOposto = widget.newButton({
            left = 80,
            top = 124,   
            fillColor = { default={1,1,1,0.7}, over={1,1,1,0.5} },
            strokeColor = { default={0.9,0.9,0.9,1}, over={0.8,0.8,0.8,1} },
            label = "+/-",
            fontSize = 30,
            shape = "roundedRect",
            width = 80,
            height = 80,
            cornerRadius = 0,
            strokeWidth = 1,
            onEvent = buttonOposto      
    })

    local btnPerc = widget.newButton({
            left = 160,
            top = 124,   
            label = "%",
            fontSize = 30,
            shape = "roundedRect",
            width = 80,
            height = 80,
            cornerRadius = 0,
            fillColor = { default={1,1,1,0.7}, over={1,1,1,0.5} },
            strokeColor = { default={0.9,0.9,0.9,1}, over={0.8,0.8,0.8,1} },
            strokeWidth = 1,
            onEvent = buttonPerc      
    })

    local btnDel = widget.newButton({
            left = 240,
            top = 124,   
            label = "DEL",
            fontSize = 30,
            shape = "roundedRect",
            width = 79,
            height = 80,
            cornerRadius = 0,
            fillColor = { default={1,1,1,0.7}, over={1,1,1,0.5} },
            strokeColor = { default={0.9,0.9,0.9,1}, over={0.8,0.8,0.8,1} },
            strokeWidth = 1,
            onEvent = buttonDel
    })

end

function onOffAudio(event)
    if (event.phase == "ended") then
        if sound == 0 then
            sound = 1
        else
            sound = 0
        end
    end
end

function calculadora:create(event)
    local SceneGroup = self.view
    

    creatButton()

    ret = display.newRect( 0, 0, display.actualContentWidth, display.actualContentHeight)
    ret:setFillColor(0.9,0.9,0.9)
    ret.x = display.contentCenterX
    ret.y = display.contentCenterY
    SceneGroup:insert(ret)

    mensagem = display.newText("Calculadora", 10,-30)
    mensagem.size=25
    mensagem:setFillColor(0.9,0.6,0)
    mensagem.anchorX, mensagem.anchorY = 0, 0

    local options = {
        width = 120,
        height = 54,
        numFrames = 2,
        sheetContentWidth = 120,
        sheetContentHeight = 108
    }
    local checkboxSheet = graphics.newImageSheet( "switchon-off.png", options )

    local checkbox = widget.newSwitch(
        {
            left = 260,
            top = -30,
            style = "checkbox",
            id = "Checkbox",
            width = 50,
            height = 25,
            onPress = onSwitchPress,
            sheet = checkboxSheet,
            frameOff = 1,
            frameOn = 2,
            onEvent = onOffAudio

        }
    )


    visor = display.newText(conta, 10, 80)
    visor.size=40
    visor:setFillColor(0.9,0.6,0)
    visor.width = 300
    visor.xAlign, visor.anchorX, visor.anchorY = "left", 0, 0
end

calculadora:addEventListener("create", calculadora)
return calculadora