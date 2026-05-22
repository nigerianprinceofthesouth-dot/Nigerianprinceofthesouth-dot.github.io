<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Don't Scream Clicker</title>
    <style>
        * {
            box-sizing: border-box;
            user-select: none;
            margin: 0;
            padding: 0;
        }

        body {
            /* Using your provided alleyway image as the main game background */
            background-image: url("https://squarespace-cdn.com");
            background-size: cover;
            background-position: center;
            background-repeat: no-repeat;
            background-attachment: fixed;
            color: #ff3333;
            font-family: 'Courier New', Courier, monospace;
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            min-height: 100vh;
            overflow: hidden;
            padding: 20px;
        }

        /* Subtle dark vignette to blend edges */
        body::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            background: radial-gradient(circle, transparent 40%, rgba(0,0,0,0.7) 100%);
            z-index: 0;
            pointer-events: none;
        }

        #game-container {
            text-align: center;
            position: relative;
            max-width: 600px;
            width: 100%;
            z-index: 1;
        }

        h1 {
            font-size: 2.5rem;
            text-shadow: 0 0 10px #ff0000;
            margin-bottom: 5px;
            letter-spacing: 2px;
            background: rgba(11, 2, 2, 0.6);
            display: inline-block;
            padding: 5px 15px;
            border-radius: 4px;
        }

        #score-display {
            font-size: 2rem;
            font-weight: bold;
            color: #ffffff;
            text-shadow: 0 0 8px #ff3333;
            margin-bottom: 25px;
            background: rgba(11, 2, 2, 0.6);
            display: inline-block;
            padding: 2px 12px;
            border-radius: 4px;
            margin-top: 5px;
        }

        #clicker-wrapper {
            position: relative;
            display: inline-block;
            margin-bottom: 30px;
            height: 320px;
            display: flex;
            align-items: center;
            justify-content: center;
            width: 100%;
        }

        #main-clicker {
            max-width: 320px;
            max-height: 300px;
            width: auto;
            height: auto;
            cursor: pointer;
            transition: transform 0.05s ease;
        }

        #main-clicker:active {
            transform: scale(0.92);
        }

        /* Skin Styling Filters */
        .skin-stage-1 { filter: drop-shadow(0 0 15px rgba(255, 0, 0, 0.6)); }
        .skin-stage-2 { filter: drop-shadow(0 0 15px rgba(255, 0, 0, 0.8)); }
        .skin-stage-3 { filter: drop-shadow(0 0 15px rgba(200, 0, 0, 0.7)); }
        .skin-stage-4 { filter: drop-shadow(0 0 25px #ff1111); animation: glitch 0.3s infinite alternate; }
        .skin-stage-5 { filter: drop-shadow(0 0 30px #ffffff); animation: pulse 1s infinite alternate; }

        @keyframes glitch {
            0% { transform: translate(1px, 1px) rotate(0deg); }
            100% { transform: translate(-1px, -1px) rotate(0.5deg); }
        }

        @keyframes pulse {
            0% { filter: drop-shadow(0 0 15px #ff0000) contrast(1); }
            100% { filter: drop-shadow(0 0 35px #ffffff) contrast(1.3); }
        }

        .floating-text {
            position: absolute;
            color: #ffffff;
            font-weight: bold;
            font-size: 1.5rem;
            pointer-events: none;
            text-shadow: 0 0 5px #ff0000;
            animation: floatUp 0.8s ease-out forwards;
            z-index: 10;
        }

        @keyframes floatUp {
            0% { opacity: 1; transform: translateY(0) scale(1); }
            100% { opacity: 0; transform: translateY(-100px) scale(0.8); }
        }

        #shop-container {
            background: rgba(20, 5, 5, 0.9);
            border: 2px solid #ff3333;
            border-radius: 8px;
            padding: 15px;
            box-shadow: 0 0 20px rgba(0, 0, 0, 0.8);
        }

        h3 {
            margin-bottom: 15px;
            font-size: 1.2rem;
            text-transform: uppercase;
            letter-spacing: 1px;
        }

        .shop-grid {
            display: grid;
            grid-template-columns: repeat(2, 1fr);
            gap: 10px;
        }

        .shop-item {
            background: #1a0505;
            border: 1px solid #ff3333;
            color: #ff8888;
            padding: 10px;
            cursor: pointer;
            border-radius: 4px;
            font-family: inherit;
            transition: all 0.2s ease;
        }

        .shop-item:hover:not(.disabled) {
            background: #ff3333;
            color: #000;
            box-shadow: 0 0 10px #ff3333;
        }

        .shop-item.disabled {
            border-color: #441111;
            color: #552222;
            cursor: not-allowed;
            background: #0a0202;
        }

        .item-cost {
            font-size: 0.8rem;
            display: block;
            margin-top: 4px;
            color: #ffffff;
        }
        
        .shop-item.disabled .item-cost {
            color: #552222;
        }
    </style>
</head>
<body>

    <div id="game-container">
        <h1>DON'T SCREAM</h1>
        <br>
        <div id="score-display">Screams: 0</div>

        <div id="clicker-wrapper">
            <img id="main-clicker" class="skin-stage-1" src="https://squarespace-cdn.com" alt="Clicker Target">
        </div>

        <div id="shop-container">
            <h3>Skins & Madness Shop</h3>
            <div class="shop-grid">
                <button class="shop-item disabled" id="skin2-btn" onclick="buySkin(2, 50)">
                    Skin 2: Skinned YOU
                    <span class="item-cost" id="skin2-cost">Cost: 50</span>
                </button>
                <button class="shop-item disabled" id="skin3-btn" onclick="buySkin(3, 250)">
                    Skin 3: Crawling Terror
                    <span class="item-cost" id="skin3-cost">Cost: 250</span>
                </button>
                <button class="shop-item disabled" id="skin4-btn" onclick="buySkin(4, 1000)">
                    Skin 4: The Suit
                    <span class="item-cost" id="skin4-cost">Cost: 1000</span>
                </button>
                <button class="shop-item disabled" id="skin5-btn" onclick="buySkin(5, 5000)">
                    Skin 5: The Council
                    <span class="item-cost" id="skin5-cost">Cost: 5000</span>
                </button>
                <button class="shop-item" id="multiplier-btn" onclick="buyUpgrade()" style="grid-column: span 2;">
                    Heavy Sigh (+1/click)
                    <span class="item-cost" id="upgrade-cost">Cost: 15</span>
                </button>
            </div>
        </div>
    </div>

    <script>
        let score = 0;
        let pointsPerClick = 1;
        let upgradeCost = 15;
        let purchasedSkins =;
        let currentSkin = 1;

        const skinImages = {
            1: "https://squarespace-cdn.com",
            2: "https://squarespace-cdn.com",
            3: "https://squarespace-cdn.com",
            4: "https://squarespace-cdn.com",
            5: "https://squarespace-cdn.com"
        };

        const scoreDisplay = document.getElementById('score-display');
        const mainClicker = document.getElementById('main-clicker');
        const clickerWrapper = document.getElementById('clicker-wrapper');
        
        const upgradeBtn = document.getElementById('multiplier-btn');
        const upgradeCostText = document.getElementById('upgrade-cost');
        const skin2Btn = document.getElementById('skin2-btn');
        const skin3Btn = document.getElementById('skin3-btn');
        const skin4Btn = document.getElementById('skin4-btn');
        const skin5Btn = document.getElementById('skin5-btn');

        mainClicker.addEventListener('mousedown', (e) => {
            score += pointsPerClick;
            updateUI();
            createFloatingText(e.clientX, e.clientY, `+${pointsPerClick}`);
        });

        function createFloatingText(x, y, text) {
            const rect = clickerWrapper.getBoundingClientRect();
            const relativeX = x - rect.left;
            const relativeY = y - rect.top;

            const floatText = document.createElement('div');
            floatText.className = 'floating-text';
            floatText.innerText = text;
            floatText.style.left = `${relativeX}px`;
            floatText.style.top = `${relativeY}px`;

            clickerWrapper.appendChild(floatText);

            setTimeout(() => {
                floatText.remove();
            }, 800);
        }

        function buyUpgrade() {
            if (score >= upgradeCost) {
                score -= upgradeCost;
                pointsPerClick += 1;
                upgradeCost = Math.floor(upgradeCost * 1.6);
                updateUI();
            }
        }
function buySkin(skinId, cost) {
if (purchasedSkins.includes(skinId)) {
equipSkin(skinId);
return;
}
if (score >= cost) {
score -= cost;
purchasedSkins.push(skinId);
equipSkin(skinId);
updateUI();
}
}
function equipSkin(skinId) {
currentSkin = skinId;
if(skinImages[skinId]) {
mainClicker.src = skinImages[skinId];
}
mainClicker.className = '';
mainClicker.classList.add(skin-stage-${skinId});
updateUI();
}
function updateUI() {
scoreDisplay.innerText = Screams: ${score};
if (score >= upgradeCost) {
upgradeBtn.classList.remove('disabled');
} else {
upgradeBtn.classList.add('disabled');
}
upgradeCostText.innerText = Cost: ${upgradeCost};
updateSkinButton(skin2Btn, 2, 50);
updateSkinButton(skin3Btn, 3, 250);
updateSkinButton(skin4Btn, 4, 1000);
updateSkinButton(skin5Btn, 5, 5000);
}
function updateSkinButton(btn, id, cost) {
const costSpan = document.getElementById(skin${id}-cost);
if (purchasedSkins.includes(id)) {
btn.classList.remove('disabled');
if (currentSkin === id) {
btn.style.borderColor = '#00ff00';
costSpan.innerText = 'EQUIPPED';
costSpan.style.color = '#00ff00';
} else {
btn.style.borderColor = '#ff3333';
costSpan.innerText = 'OWNED';
costSpan.style.color = '#ff8888';
}
} else {
if (score >= cost) {
btn.classList.remove('disabled');
} else {
btn.classList.add('disabled');
}
costSpan.innerText = Cost: ${cost};
costSpan.style.color = '#ffffff';
}
}
updateUI();
