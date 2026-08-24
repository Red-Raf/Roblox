local Env = getfenv();
local A = {};
local v1 = {...};
local r1 = true;
local r2 = string.gmatch;
local function r3(...)
    error("Tamper Detected!");
    return; 
end;
local r4 = false;
local v2 = pcall(function(...)
    r4 = true;
    return; 
end);
local v3 = v2;
if v2 then
    v3 = r4;
end;
local v4 = 1;
local r5 = math.random;
local v5 = table.concat;
local v6 = table;
local function v7(...)
    while true do
        l1 = l2;
        l2 = l1;
        r3(); 
    end;
    return; 
end;
if v6 then
    y = table.unpack;
end;
local r6 = v6 or unpack;
local r7 = r5(3, 65);
local v8 = {
    pcall(function(...)
        return "lyhMrvee" / (12294592 - "G05uk3mX0X8kXj0" ^ 1468503); 
    end)
};
local v9 = v8[2];
local r8 = tonumber(r2(tostring(v9), ":(%d*):")());
for J = 1, r7 do
    r9 = J;
    r10 = math.random(1, 100);
    r11 = r5(0, 255);
    r12 = r5(1, r10);
    r13 = r5(1, 2) == 1;
    r14 = v9.gsub(v9, ":(%d*):", ":" .. tostring(r5(0, 10000)) .. ":");
    d = {
        pcall(function(...)
            if r5(1, 2) == 1 or r9 == r7 then
                r1 = r1 and r8 == tonumber(r2(tostring(({
                    pcall(function(...)
                        return "hCxvedV" / (3365287 - "EA" ^ 13002863); 
                    end)
                })[2]), ":(%d*):")());
            end;
            if r13 then
                error(r14, 0);
            end;
            v1 = {};
            for H = 1, r10 do
                v1[H] = r5(0, 255); 
            end;
            v1[r12] = r11;
            return r6(v1); 
        end)
    };
    if r13 then
        r1 = r1 and (pcall(function(...)
            if r5(1, 2) == 1 or r9 == r7 then
                r1 = r1 and r8 == tonumber(r2(tostring(({
                    pcall(function(...)
                        return "hCxvedV" / (3365287 - "EA" ^ 13002863); 
                    end)
                })[2]), ":(%d*):")());
            end;
            if r13 then
                error(r14, 0);
            end;
            v1 = {};
            for H = 1, r10 do
                v1[H] = r5(0, 255); 
            end;
            v1[r12] = r11;
            return r6(v1); 
        end) == false and d[2] == r14);
    end; 
end;
r1 = r1 and 0 == 0;
if r1 then
    r17 = math.floor;
    r18 = 0;
    r19 = 2;
    r20 = {};
    v6 = 0;
    v8 = {};
    for N = 1, 256 do
        v8[N] = N; 
    end;
    v9 = #v8 == 0;
    N = table.remove(v8, math.random(1, #v8));
    r20[N] = string.char(N - 1);
    if #v8 == 0 then
        r21 = {};
        r23 = {};
        r15 = setmetatable({}, {
            ["__index"] = r23,
            ["__metatable"] = nil
        });
        H = game;
        r24 = H.GetService(H, "Players");
        Q = game;
        r25 = Q.GetService(Q, "RunService");
        v4 = game;
        r26 = v4.GetService(v4, "Workspace");
        v2 = game;
        r27 = v2.GetService(v2, "UserInputService");
        v7 = game;
        v7.GetService(v7, "StarterGui");
        v7 = game;
        r28 = v7.GetService(v7, "Lighting");
        w = game;
        r29 = w.GetService(w, "TweenService");
        v6 = game;
        r30 = v6.GetService(v6, "VirtualInputManager");
        P = game;
        r31 = P.GetService(P, "MaterialService");
        v8 = game;
        r32 = v8.GetService(v8, "ContentProvider");
        v9 = game;
        r33 = v9.GetService(v9, "ReplicatedStorage");
        r34 = r24.LocalPlayer;
        r35 = workspace.CurrentCamera;
        E = game;
        r36 = loadstring(E.HttpGet(E, "https://raw.githubusercontent.com/Footagesus/WindUI/main/dist/main.lua"))();
        N = not r36;
        if N then
            N = game.StarterGui;
            N.SetCore(N, "SendNotification", {
                ["Title"] = "Error",
                ["Text"] = "WindUI not loaded!",
                ["Duration"] = 5
            });
            return;
        end;
        N = r36;
        Qh[42] = "B\xe8h\\\xa7\x0c\xd6-[\x08M\x1c\xb1]";
        N.SetTheme(N, "Violet");
        Qh[9] = 32755099794324;
        Qh[4] = "\xe9\x1d:c\x1d.'\x12F\xa9\xb6\xa7\xb1";
        Qh[7] = 33134247279685;
        r36.TransparencyValue = .1;
        Qh[30] = "\x82\xc0\x9e\xd0\xe0b\xf7\x0b\x96b\x8f\x1d0\xbc\xad\x9d";
        E = r36;
        Qh[17] = 30050668918441;
        Qh[28] = 1389767885447;
        Qh[11] = 17539642187751;
        Qh[27] = "\x9e\x8b\x82E\xdf\xe4]";
        Qh[35] = 23628452588282;
        Qh[24] = "fR\xd8p\xef\x91\xeah\x0b";
        Qh[20] = "j\xdd\xf0St\xf2[\xf8\xd4\xc3\xd7\xaf*";
        r37 = E.CreateWindow(E, {
            ["Title"] = "PlanetHub",
            ["Author"] = "MMV and MM2",
            ["Icon"] = "crown",
            ["Folder"] = "PlanetHubSettings",
            ["Size"] = UDim2.fromOffset(720, 600),
            ["Resizable"] = true,
            ["Transparent"] = true,
            ["Theme"] = "Violet",
            ["SideBarWidth"] = 190,
            ["HideSearchBar"] = false
        });
        Qh[23] = 9017974722663;
        Qh[40] = 8364506517303;
        Qh[13] = 27060299313464;
        Qh[21] = 20314360374515;
        (function(...)
            v1 = Instance.new("TextLabel");
            v1.Name = "ReleaseBadge";
            v1.Size = UDim2.new(0, 65, 0, 20);
            v1.Position = UDim2.new(0, 160, 0, 12);
            v1.BackgroundColor3 = Color3.fromRGB(138, 43, 226);
            v1.BackgroundTransparency = .15;
            v1.TextColor3 = Color3.fromRGB(255, 255, 255);
            v1.Text = "\xd0\xa0\xd0\xb5\xd0\xbb\xd0\xb8\xd0\xb7";
            v1.TextSize = 11;
            v1.Font = Enum.Font.GothamBold;
            v1.BorderSizePixel = 0;
            v1.TextStrokeColor3 = Color3.fromRGB(138, 43, 226);
            v1.TextStrokeTransparency = 0;
            j = Instance.new("UICorner");
            j.CornerRadius = UDim.new(0, 10);
            j.Parent = v1;
            return v1; 
        end)().Parent = r37.UIElements.Main;
        Qh[2] = "B1oM\xeb\xbc\xfd9\xea#Q\xd1\x04\xcb&";
        local function r38(arg1_2, arg2_2, arg3_2, ...)
            r39 = arg1_2;
            r40 = arg2_2;
            r41 = arg3_2;
            pcall(function(...)
                local F = {
                    F[1],
                    F[2],
                    F[3],
                    199,
                    200,
                    201
                };
                v5 = A[F[1]];
                v7 = v5;
                v5.Notify(v5, {
                    ["Title"] = r39,
                    ["Content"] = r40,
                    ["Duration"] = r41 or 3
                });
                return; 
            end);
            return; 
        end;
        Qh[16] = 3820102059762;
        Qh[25] = 19383210910530;
        Qh[41] = 32375275027171;
        Qh[18] = "\xc5?E\xd1O\x11p\xdfJ\x03\xf7\xfa\xd7\x00\x93]\x1a1\xc8";
        Qh[36] = " \xc5Wy\xe4\xdd\xc3\xbfu\xc1\xe5!u\xdf+";
        Qh[15] = "8\x9f\xe8\xcd\x1f*\x9e";
        Qh[8] = "b\xba\x90GP\xb3w\xaf\xaf\xc8>?#\xe7J";
        Qh[31] = 32684659194739;
        Qh[3] = 11172951757906;
        Qh[6] = 8474227134314;
        Qh[5] = 25693083725500;
        Qh[1] = 20959386150431;
        Qh[43] = 19736483324902;
        Qh[1] = r16(Qh[2], Qh[3]);
        Qh[22] = "*\x80\x9fi`\xb2\xe5\xd0\xc5\xb0\x14";
        Qh[1] = r15;
        Qh[2] = r16;
        Qh[3] = Qh[2](Qh[4], Qh[5]);
        Qh[2] = r15;
        Qh[3] = r16;
        Qh[5] = "\xc4#b\x86\x0f\xe7\xa2";
        Qh[32] = "\x13\xe4\xf8\x82\xff\xf9\x1cO\xe9\xa9\xf2\xc2";
        Qh[4] = Qh[3](Qh[5], Qh[6]);
        Qh[12] = "\xber>\xf5\xd9\xafj\x1d\xc1\x96:3\x0b";
        Qh[1] = Qh[2][Qh[4]];
        Qh[3] = r15;
        Qh[4] = r16;
        Qh[6] = "-\xa3\xdb\xc2uXiF\x82\xad\x00?\xf4P\x9b\xe8\x80d\xaf\xf6";
        Qh[5] = Qh[4](Qh[6], Qh[7]);
        Qh[37] = 23411559410325;
        Qh[2] = Qh[3][Qh[5]];
        Qh[3] = .3;
        Qh[10] = "|f\xf7\xea-#\xa6\x82\xc5$;\xc4\xc1E\xa4\x993Q`\x86";
        Qh[5] = r15;
        Qh[6] = r16;
        Qh[7] = Qh[6](Qh[8], Qh[9]);
        Qh[4] = Qh[5][Qh[7]];
        Qh[19] = 27773888557701;
        Qh[5] = false;
        Qh[33] = 26598452555873;
        Qh[7] = r15;
        Qh[8] = r16;
        Qh[9] = Qh[8](Qh[10], Qh[11]);
        Qh[6] = Qh[7][Qh[9]];
        Qh[7] = 5;
        Qh[9] = r15;
        Qh[10] = r16;
        Qh[11] = Qh[10](Qh[12], Qh[13]);
        Qh[8] = Qh[9][Qh[11]];
        Qh[11] = "Color3";
        Qh[10] = Env[Qh[11]];
        Qh[12] = r15;
        Qh[13] = r16;
        Qh[14] = Qh[13](Qh[15], Qh[16]);
        Qh[16] = "\x158zJ\xfaL\xdd\xc9\xb9\x98Fqz\xa8";
        Qh[11] = Qh[12][Qh[14]];
        Qh[9] = Qh[10][Qh[11]];
        Qh[12] = 255;
        Qh[11] = 0;
        Qh[15] = 16694661029470;
        Qh[44] = 15083714599791;
        Qh[13] = 255;
        Qh[10] = Qh[9](Qh[11], Qh[12], Qh[13]);
        Qh[14] = "\x1dO\xd5v\xc3\x80\xcfO\xca2K\x8e\x83}";
        Qh[11] = r15;
        Qh[12] = r16;
        Qh[13] = Qh[12](Qh[14], Qh[15]);
        Qh[9] = Qh[11][Qh[13]];
        Qh[13] = r15;
        Qh[11] = 2.4;
        Qh[14] = r16;
        Qh[15] = Qh[14](Qh[16], Qh[17]);
        Qh[12] = Qh[13][Qh[15]];
        Qh[15] = r15;
        Qh[16] = r16;
        Qh[17] = Qh[16](Qh[18], Qh[19]);
        Qh[14] = Qh[15][Qh[17]];
        Qh[13] = 1.6;
        Qh[38] = "\x1c\xf4o\xd9Z\x0c7d";
        Qh[15] = 0;
        Qh[17] = r15;
        Qh[18] = r16;
        Qh[19] = Qh[18](Qh[20], Qh[21]);
        Qh[16] = Qh[17][Qh[19]];
        Qh[19] = r15;
        Qh[17] = 25;
        Qh[20] = r16;
        Qh[21] = Qh[20](Qh[22], Qh[23]);
        Qh[18] = Qh[19][Qh[21]];
        Qh[21] = r15;
        Qh[22] = r16;
        Qh[19] = false;
        Qh[23] = Qh[22](Qh[24], Qh[25]);
        Qh[20] = Qh[21][Qh[23]];
        Qh[23] = "Color3";
        Qh[22] = Env[Qh[23]];
        Qh[24] = r15;
        Qh[25] = r16;
        Qh[26] = Qh[25](Qh[27], Qh[28]);
        Qh[23] = Qh[24][Qh[26]];
        Qh[39] = 9732607693236;
        Qh[24] = 220;
        Qh[25] = 255;
        Qh[34] = "\x01\xf0+P\xb5`\x17\xcc\x92\xa4z\xb4_|";
        Qh[29] = 30986330814557;
        Qh[21] = Qh[22][Qh[23]];
        Qh[23] = 133;
        Qh[22] = Qh[21](Qh[23], Qh[24], Qh[25]);
        Qh[27] = 30215266383606;
        Qh[28] = "\x83\x88v\xb1\xbb\xa6\xc8\x8d\x1bp\x0f\xaa";
        Qh[26] = "J\x83\xff\xccn\x99m\r\x12{~";
        Qh[23] = r15;
        Qh[24] = r16;
        Qh[25] = Qh[24](Qh[26], Qh[27]);
        Qh[21] = Qh[23][Qh[25]];
        Qh[25] = r15;
        Qh[26] = r16;
        Qh[23] = false;
        Qh[27] = Qh[26](Qh[28], Qh[29]);
        Qh[24] = Qh[25][Qh[27]];
        Qh[27] = r15;
        Qh[28] = r16;
        Qh[25] = false;
        Qh[29] = Qh[28](Qh[30], Qh[31]);
        Qh[26] = Qh[27][Qh[29]];
        Qh[27] = false;
        Qh[29] = r15;
        Qh[30] = r16;
        Qh[31] = Qh[30](Qh[32], Qh[33]);
        Qh[28] = Qh[29][Qh[31]];
        Qh[29] = 120;
        Qh[31] = r15;
        Qh[32] = r16;
        Qh[33] = Qh[32](Qh[34], Qh[35]);
        Qh[30] = Qh[31][Qh[33]];
        Qh[33] = r15;
        Qh[34] = r16;
        Qh[31] = false;
        Qh[35] = Qh[34](Qh[36], Qh[37]);
        Qh[32] = Qh[33][Qh[35]];
        Qh[33] = false;
        Qh[35] = r15;
        Qh[36] = r16;
        Qh[37] = Qh[36](Qh[38], Qh[39]);
        Qh[39] = "";
        Qh[34] = Qh[35][Qh[37]];
        Qh[36] = r15;
        Qh[37] = r16;
        Qh[38] = Qh[37](Qh[39], Qh[40]);
        Qh[35] = Qh[36][Qh[38]];
        Qh[40] = "\x89\x80:\xa7\x9a\xce\xe9\xb9\xe08f\x05UB\xb3\xccN\x00";
        Qh[37] = r15;
        Qh[38] = r16;
        Qh[39] = Qh[38](Qh[40], Qh[41]);
        Qh[36] = Qh[37][Qh[39]];
        Qh[39] = r15;
        Qh[37] = false;
        Qh[40] = r16;
        Qh[41] = Qh[40](Qh[42], Qh[43]);
        Qh[43] = "G";
        Qh[38] = Qh[39][Qh[41]];
        Qh[40] = r15;
        Qh[41] = r16;
        Qh[42] = Qh[41](Qh[43], Qh[44]);
        Qh[39] = Qh[40][Qh[42]];
        Qh[15] = "Z\xdf.\x9d\x98a\xb8tk\xd0\x8d";
        r42 = {
            ["MurderESP"] = false,
            ["SheriffESP"] = false,
            ["InnocentESP"] = false,
            ["ChamsEnabled"] = false,
            ["ChamsColor"] = "Purple",
            ["TracersEnabled"] = false,
            ["JumpCircles"] = false,
            ["Trails"] = false,
            ["RGBHumanoid"] = false,
            ["XRayEnabled"] = false,
            ["BloomEnabled"] = false,
            ["ColorCorrectionEnabled"] = false,
            ["VignetteEnabled"] = false,
            ["CustomSkyId"] = "",
            ["FlyEnabled"] = false,
            ["FlySpeed"] = 50,
            ["BHopEnabled"] = false,
            ["BHopSpeed"] = 30,
            ["SpinBotEnabled"] = false,
            ["SpinBotSpeed"] = 9999,
            ["AntiFlingEnabled"] = false,
            ["FovAimbotEnabled"] = false,
            ["FovRadius"] = 120,
            ["AutoFarmEnabled"] = false,
            ["AutoFarmSpeed"] = 20,
            ["AutoFarmCoinLimit"] = 40,
            ["AutoFarmCoinDelay"] = .15,
            ["AutoRespawn"] = true,
            ["AntiAFKEnabled"] = false,
            ["ShootButtonEnabled"] = false,
            ["GrabGunEnabled"] = false,
            ["SheriffAutoShootEnabled"] = false,
            ["WallHopEnabled"] = false,
            [r15[r16("\xa6`M\xce\x9c\xc9\xa2\xbf-\\{*\xdd\x8d\xae;\xce`", Qh[1])]] = false,
            [r15[Qh[1]]] = false,
            [Qh[1][Qh[3]]] = Qh[1],
            [Qh[2]] = Qh[3],
            [Qh[4]] = Qh[5],
            [Qh[6]] = Qh[7],
            [Qh[8]] = Qh[10],
            [Qh[9]] = Qh[11],
            [Qh[12]] = Qh[13],
            [Qh[14]] = Qh[15],
            [Qh[16]] = Qh[17],
            [Qh[18]] = Qh[19],
            [Qh[20]] = Qh[22],
            [Qh[21]] = Qh[23],
            [Qh[24]] = Qh[25],
            [Qh[26]] = Qh[27],
            [Qh[28]] = Qh[29],
            [Qh[30]] = Qh[31],
            [Qh[32]] = Qh[33],
            [Qh[34]] = Qh[35],
            [Qh[36]] = Qh[37],
            [Qh[38]] = Qh[39]
        };
        Qh[20] = 7732460113424;
        Qh[2] = 1463926735529;
        Qh[8] = 9108458459281;
        Qh[11] = "y\x88\x1f\x84\x90v\xbc\\\xdc\xa0\\b]";
        Qh[1] = "2\xb6\xff\tw7\xd3(\xf7\xf1";
        Qh[17] = "\xc2rVE\xe0M\x1c\xbd\x90\x16\xfa\xbd\xe0";
        Qh[5] = "\x1bxi;\xed\xd4[\t\xb2\xa7\"";
        hw = r15;
        Qh[3] = "\xa5\x18m\x7fy\x88\\\xa4";
        Qh[18] = 3100805072291;
        Qh[19] = "\x05K\xe8fJ\x8a^\xe3Z\x13\x81\x00\xd9\tM";
        Qh[13] = "\xbe3\x92j\r\x149\x10_\x1d\x92\xa1c\xfb\xe0";
        Qh[16] = 3594075752073;
        Qh[6] = 31810770057693;
        Qh[7] = "\x03\xbb\x01\x17\xaf\x84\xad>\x8f\x0f\xa6\xa7pv";
        Qh[12] = 3568843294333;
        Qh[9] = "\x85\x13\xc5m.VE\xb3\xbd\x0f\xc9H\x87e\xcb";
        Qh[14] = 33447651196119;
        Qh[4] = 15763372629164;
        Qh[1] = r16;
        Qh[2] = Qh[1](Qh[3], Qh[4]);
        Qh[2] = r15;
        Qh[3] = r16;
        Qh[4] = Qh[3](Qh[5], Qh[6]);
        Qh[1] = Qh[2][Qh[4]];
        Qh[2] = nil;
        Qh[4] = r15;
        Qh[5] = r16;
        Qh[10] = 29837761836614;
        Qh[6] = Qh[5](Qh[7], Qh[8]);
        Qh[3] = Qh[4][Qh[6]];
        Qh[6] = r15;
        Qh[7] = r16;
        Qh[4] = {};
        Qh[8] = Qh[7](Qh[9], Qh[10]);
        Qh[5] = Qh[6][Qh[8]];
        Qh[6] = nil;
        Qh[8] = r15;
        Qh[9] = r16;
        Qh[10] = Qh[9](Qh[11], Qh[12]);
        Qh[7] = Qh[8][Qh[10]];
        Qh[10] = r15;
        Qh[11] = r16;
        Qh[12] = Qh[11](Qh[13], Qh[14]);
        Qh[8] = nil;
        Qh[9] = Qh[10][Qh[12]];
        Qh[10] = nil;
        Qh[12] = r15;
        Qh[13] = r16;
        Qh[14] = Qh[13](Qh[15], Qh[16]);
        Qh[11] = Qh[12][Qh[14]];
        Qh[14] = r15;
        Qh[15] = r16;
        Qh[12] = nil;
        Qh[16] = Qh[15](Qh[17], Qh[18]);
        Qh[13] = Qh[14][Qh[16]];
        Qh[14] = nil;
        Qh[16] = r15;
        Qh[17] = r16;
        Qh[18] = Qh[17](Qh[19], Qh[20]);
        Qh[15] = Qh[16][Qh[18]];
        Qh[16] = nil;
        r43 = {
            ["Highlights"] = {},
            ["ChamsPartsList"] = {},
            ["PostEffects"] = {},
            ["JumpTracking"] = {
                ["wasJumping"] = false
            },
            ["RGBConnection"] = nil,
            ["AutoFarmConn"] = nil,
            ["CurrentTween"] = nil,
            ["XRayParts"] = {},
            ["Tracers"] = {},
            ["TrailAttachments"] = hw,
            ["FovCircle"] = nil,
            ["FovConnection"] = nil,
            ["FlyRunning"] = false,
            ["FlyKeys"] = {
                ["F"] = 0,
                ["B"] = 0,
                ["L"] = 0,
                ["R"] = 0
            },
            ["FlyBodyGyro"] = nil,
            ["FlyBodyVelocity"] = nil,
            ["FlyConn"] = nil,
            ["FlyKeyConn"] = nil,
            ["FlyKeyEndConn"] = nil,
            ["mainConn"] = nil,
            ["GrabGunRunning"] = false,
            ["WallHopConnection"] = nil,
            ["SheriffAutoShootConnection"] = nil,
            ["ChinaHatParts"] = {},
            ["ChinaHatConnection"] = nil,
            ["ChinaHatDrawings"] = {},
            ["TextureState"] = {},
            ["TextureVariantsBuilt"] = false,
            ["AuraParticles"] = {},
            ["AuraCache"] = {},
            ["JerkConnection"] = nil,
            ["BHopConn"] = nil,
            ["BHopBV"] = nil,
            [r15[r16(Qh[1], Qh[2])]] = false,
            [r15[Qh[2]]] = nil,
            [Qh[1]] = Qh[2],
            [Qh[3]] = Qh[4],
            [Qh[5]] = Qh[6],
            [Qh[7]] = Qh[8],
            [Qh[9]] = Qh[10],
            [Qh[11]] = Qh[12],
            [Qh[13]] = Qh[14],
            [Qh[15]] = Qh[16]
        };
        r44 = {
            ["Murder"] = Color3.fromRGB(255, 0, 0),
            ["Sheriff"] = Color3.fromRGB(0, 100, 255),
            ["Innocent"] = Color3.fromRGB(138, 43, 226),
            ["Purple"] = Color3.fromRGB(138, 43, 226),
            ["White"] = Color3.fromRGB(255, 255, 255),
            ["Red"] = Color3.fromRGB(255, 50, 50),
            ["Blue"] = Color3.fromRGB(0, 100, 255),
            ["Green"] = Color3.fromRGB(0, 255, 0)
        };
        d = {
            ["Purple"] = Color3.fromRGB(138, 43, 226),
            ["Blue"] = Color3.fromRGB(0, 100, 255),
            ["Red"] = Color3.fromRGB(255, 0, 0),
            ["Green"] = Color3.fromRGB(0, 255, 0)
        };
        local function r45(arg1_3, ...)
            r46 = arg1_3;
            if r46 and typeof(r46) == "RBXScriptConnection" then
                pcall(function(...)
                    v5 = r46;
                    v5.Disconnect(v5);
                    return; 
                end);
            end;
            return; 
        end;
        local function r47(arg1_4, ...)
            v1 = arg1_4;
            if not v1 or not v1.Character then
                return false;
            end;
            e = v1.Character;
            j = e[2];
            H = e[3];
            for H, v4 in ipairs(e.GetDescendants(e)) do
                v2 = "Tool";
                Q = H;
                v5 = v4.IsA(v4, v2);
                if v5 then
                    v5 = v4.Name;
                    v2 = v5.lower(v5);
                    if v2.find(v2, "knife") or v2.find(v2, "blade") then
                        return true;
                    else
                        
                    end;
                end; 
            end;
            j = v1.FindFirstChild(v1, "Backpack");
            if j then
                v2 = j.GetChildren;
                e = v2[2];
                H = v2[1];
                for Q, v2 in ipairs(v2(j)) do
                    v4 = Q;
                    v7 = "Tool";
                    v5 = v2.IsA(v2, v7);
                    if v5 then
                        v5 = v2.Name;
                        v7 = v5.lower(v5);
                        if v7.find(v7, "knife") or v7.find(v7, "blade") then
                            return true;
                        else
                            
                        end;
                    end; 
                end;
            end;
            return false; 
        end;
        local function r48(arg1_5, ...)
            v1 = arg1_5;
            if not v1 or not v1.Character then
                return false;
            end;
            e = v1.Character;
            H = e[3];
            e = e[1];
            for H, v4 in e, ipairs(e.GetDescendants(e)) do
                Q = H;
                v2 = "Tool";
                v5 = v4.IsA(v4, v2);
                if v5 then
                    v5 = v4.Name;
                    v2 = v5.lower(v5);
                    if v2.find(v2, "gun") or (v2.find(v2, "pistol") or v2.find(v2, "revolver")) then
                        return true;
                    else
                        
                    end;
                end; 
            end;
            j = v1.FindFirstChild(v1, "Backpack");
            if j then
                v2 = j.GetChildren;
                H = v2[1];
                e = v2[2];
                for Q, v2 in ipairs(v2(j)) do
                    v4 = Q;
                    v7 = "Tool";
                    v5 = v2.IsA(v2, v7);
                    if v5 then
                        v5 = v2.Name;
                        v7 = v5.lower(v5);
                        if v7.find(v7, "gun") or (v7.find(v7, "pistol") or v7.find(v7, "revolver")) then
                            return true;
                        else
                            
                        end;
                    end; 
                end;
            end;
            return false; 
        end;
        local function r49(arg1_6, ...)
            v1 = arg1_6;
            if r47(v1) then
                return "\xd0\xa3\xd0\xb1\xd0\xb8\xd0\xb9\xd1\x86\xd0\xb0";
            end;
            if r48(v1) then
                return "\xd0\xa8\xd0\xb5\xd1\x80\xd0\xb8\xd1\x84";
            end;
            return "\xd0\x9d\xd0\xb5\xd0\xb2\xd0\xb8\xd0\xbd\xd0\xbd\xd1\x8b\xd0\xb9"; 
        end;
        local function r50(arg1_7, ...)
            j = r49(arg1_7);
            if j == "\xd0\xa3\xd0\xb1\xd0\xb8\xd0\xb9\xd1\x86\xd0\xb0" then
                return r44.Murder;
            end;
            if j == "\xd0\xa8\xd0\xb5\xd1\x80\xd0\xb8\xd1\x84" then
                return r44.Sheriff;
            end;
            return r44.Purple; 
        end;
        local function r51(...)
            if not r34.Character then
                return false;
            end;
            H = r34.Character;
            v1 = H[2];
            j = H[3];
            H = "ipairs";
            for j, Q in ipairs(H.GetDescendants(H)) do
                e = j;
                r52 = Q;
                v5 = r52;
                v4 = v5.IsA(v5, "Tool");
                if v4 then
                    v5 = r52.Name;
                    v4 = v5.lower(v5);
                    if v4.find(v4, "gun") or (v4.find(v4, "pistol") or v4.find(v4, "revolver")) then
                        pcall(function(...)
                            v5 = r34.Character.Humanoid;
                            v5.EquipTool(v5, r52);
                            return; 
                        end);
                        return true;
                    else
                        
                    end;
                end; 
            end;
            v5 = r34;
            v1 = v5.FindFirstChild(v5, "Backpack");
            if v1 then
                v4 = v1.GetChildren;
                H = v4[2];
                j = v4[1];
                for e, v4 in ipairs(v4(v1)) do
                    Q = e;
                    r53 = v4;
                    v5 = r53;
                    v2 = v5.IsA(v5, "Tool");
                    if v2 then
                        v5 = r53.Name;
                        v2 = v5.lower(v5);
                        if v2.find(v2, "gun") or (v2.find(v2, "pistol") or v2.find(v2, "revolver")) then
                            pcall(function(...)
                                v5 = r34.Character.Humanoid;
                                v5.EquipTool(v5, r53);
                                return; 
                            end);
                            return true;
                        else
                            
                        end;
                    end; 
                end;
            end;
            return false; 
        end;
        local function r54(arg1_8, ...)
            v1 = arg1_8;
            e = RaycastParams.new();
            e.FilterType = Enum.RaycastFilterType.Exclude;
            Q = r34.Character;
            if Q then
                e.FilterDescendantsInstances = {
                    Q
                };
            end;
            v5 = r26;
            v4 = v5.Raycast(v5, v1, Vector3.new(0, -50, 0), e);
            if v4 then
                return v4.Position.v3;
            end;
            return v1.v3 - 3; 
        end;
        local function r55(arg1_9, ...)
            v1 = arg1_9;
            if not v1 or not v1.Character then
                return false;
            end;
            v5 = v1.Character;
            j = v5.FindFirstChild(v5, "HumanoidRootPart");
            if not j then
                return false;
            end;
            H = r34.Character;
            v3 = H;
            H = v3 and H.FindFirstChild(H, "HumanoidRootPart");
            if not H then
                return false;
            end;
            e = RaycastParams.new();
            e.FilterType = Enum.RaycastFilterType.Blacklist;
            e.FilterDescendantsInstances = {
                r34.Character,
                v1.Character
            };
            v5 = r26;
            return not v5.Raycast(v5, H.Position, j.Position - H.Position, e); 
        end;
        local function r56(arg1_10, arg2_10, arg3_10, arg4_10, ...)
            j = arg2_10;
            H = arg3_10;
            v1 = arg1_10;
            r57 = arg4_10;
            r57 = r57 or .2;
            v4 = A[j];
            if H then
                v5 = v5;
                H = H;
                v4 = (v1 - j).Magnitude;
                if v4 < 1 then
                    return;
                end;
                r58 = Instance.new("Part");
                r58.Name = "GunBeam";
                r58.Size = Vector3.new(.15, .15, v4);
                r58.CFrame = CFrame.lookAt(v1, j) * CFrame.new(0, 0, -v4 / 2);
                r58.Anchored = true;
                r58.CanCollide = false;
                r58.Material = Enum.Material.Neon;
                w = H;
                r58.Color = w;
                r58.Transparency = .1;
                r58.Parent = workspace;
                y = Instance.new("PointLight");
                y.Color = H;
                y.Brightness = 10;
                y.Range = 15;
                y.Parent = r58;
                task.spawn(function(...)
                    for m = 1, 10 do
                        task.wait(r57 / 10);
                        r58.Transparency = r58.Transparency + .09;
                        r58.Size = Vector3.new(r58.Size.v2 * .95, r58.Size.v3 * .95, r58.Size.Z); 
                    end;
                    v5 = r58;
                    v5.Destroy(v5);
                    return; 
                end);
                return r58;
            else
                Q = Color3.fromRGB(180, 50, 255);
            end; 
        end;
        r59 = {
            ["angel"] = "97658130917593",
            ["starlight"] = "134645216613107",
            ["heavenly"] = "139300897520961",
            ["ribbon"] = "132069507632161",
            ["sakura"] = "81755778619404",
            ["wind"] = "80694081850877",
            ["flow"] = "119913533725648",
            ["star"] = "73754563740680"
        };
        hw = "flow";
        r60 = {
            "angel",
            "starlight",
            "heavenly",
            "ribbon",
            "sakura",
            "wind",
            hw,
            "star"
        };
        r61 = {};
        Qw = r60;
        ew = hw[2];
        Ww = hw[3];
        for Ww, Qw in ipairs(Qw),  do
            Aw = Ww;
            r61[Qw] = false; 
        end;
        local function r62(...)
            e = r43;
            H = e.AuraParticles;
            H = e[1];
            v1 = e[2];
            for j, Q in ipairs(H) do
                e = j;
                r63 = Q;
                pcall(function(...)
                    v5 = r63;
                    v5.Destroy(v5);
                    return; 
                end); 
            end;
            r43.AuraParticles = {};
            return; 
        end;
        local function r64(arg1_11, ...)
            v1 = arg1_11;
            if r43.AuraCache[v1] then
                return r43.AuraCache[v1];
            end;
            j = r59[v1];
            if not j then
                return nil;
            end;
            v2 = {
                pcall(game.GetObjects, game, "rbxassetid://" .. j)
            };
            H = v2[2];
            e = pcall(game.GetObjects, game, "rbxassetid://" .. j);
            if e then
                if H then
                    Q = v2[2][1];
                end;
                v5 = pcall;
                v3 = H;
            end;
            if e then
                r43.AuraCache[v1] = H[1];
                return H[1];
            end;
            return nil; 
        end;
        local function r65(arg1_12, arg2_12, ...)
            v1 = arg1_12;
            ColorSequence.new(arg2_12);
            v2 = v1.GetDescendants;
            v4 = {
                v2(v1)
            };
            e = v2[2];
            v4 = v2[1];
            for Q, v7 in ipairs(C(v4)) do
                v2 = Q;
                if v7.IsA(v7, "PointLight") then
                    v7.Color = arg2_12;
                else
                    if v7.IsA(v7, "ParticleEmitter") or (v7.IsA(v7, "Beam") or v7.IsA(v7, "Trail")) then
                        v7.Color = ColorSequence.new(j);
                    end;
                end; 
            end;
            return; 
        end;
        local function r66(...)
            r62();
            if not r42.AuraEnabled then
                return;
            end;
            v1 = r34.Character;
            if not v1 then
                return;
            end;
            v4 = r16("M\x7f87N\xb8", 29922532390509);
            if v1[r15[v4]] ~= workspace then
                v4 = workspace;
                v2 = {
                    v4.GetChildren(v4)
                };
                Q = v4[3];
                e = v4[2];
                for Q, v2 in ipairs(C(v2)) do
                    v4 = Q;
                    if v2.IsA(v2, "Model") and v2.Name == r34.Name then
                        v7 = v2.GetAttribute(v2, "1") or v2 == _G.VIEWPORT_CLONE;
                        v5 = v7;
                        if not v7 then
                            v7 = v2.FindFirstChild(v2, "HumanoidRootPart");
                            if v7 then
                                v3 = v7.IsA(v7, "BasePart");
                            end;
                            v5 = v5;
                            if v7 then
                                j = v2;
                            else
                                
                            end;
                        end;
                    end; 
                end;
            end;
            if not v1 then
                return;
            end;
            v2 = r60;
            e = 29922532390509[1];
            Q = 29922532390509[2];
            for v4, v2 in ipairs(v2) do
                H = v4;
                if r61[v2] then
                    y = r64(v2);
                    if y then
                        r65(y, r42.AuraColor);
                        v7 = y.Clone(y);
                        N = v7.GetChildren;
                        v9 = {
                            N(v7)
                        };
                        v8 = N[3];
                        for v8, v9 in N[1], ipairs(C(v9)) do
                            w = v8;
                            c = "}*\x97W";
                            N = v1.FindFirstChild(v1, v9[r15[r16(c, 26478472228906)]]);
                            if N then
                                J = N.IsA(N, "BasePart");
                            end;
                            v5 = v3 ~= workspace;
                            if N then
                                c = v9.GetChildren;
                                T = {
                                    c(v9)
                                };
                                i = c[3];
                                k = c[2];
                                for i, T in ipairs(C(T)) do
                                    J = i;
                                    z = j.FindFirstChild(j, v9[k[T]]);
                                    T.Parent = z;
                                    table.insert(r43.AuraParticles, T); 
                                end;
                            end; 
                        end;
                        v7.Destroy(v7);
                    end;
                end; 
            end;
            return; 
        end;
        Qh[4] = "\x16:\xd9X\xe6{U\xfa\x97";
        local function r67(arg1_13, ...)
            v1 = arg1_13;
            r42.AuraEnabled = v1;
            if v1 then
                r66();
            else
                r62();
            end;
            return; 
        end;
        Qh[6] = "\xf2|>\xdd\x0f\xceC\x02\xf7\xa5";
        local function r68(arg1_14, ...)
            v1 = arg1_14;
            r42.JerkEnabled = v1;
            if v1 then
                if r43.JerkConnection then
                    v5 = r43.JerkConnection;
                    v5.Disconnect(v5);
                    r43.JerkConnection = nil;
                end;
                j = r25.Heartbeat;
                r43.JerkConnection = j.Connect(j, function(...)
                    if not r34.Character then
                        return;
                    end;
                    v5 = r34.Character;
                    v1 = v5.FindFirstChild(v5, "HumanoidRootPart");
                    if not v1 then
                        return;
                    end;
                    v1.AssemblyLinearVelocity = Vector3.new(math.random(-50, 50), math.random(-30, 30), math.random(-50, 50));
                    return; 
                end);
                r38("Jerk", "\xd0\x92\xd0\xba\xd0\xbb\xd1\x8e\xd1\x87\xd0\xb5\xd0\xbd", 2);
            else
                if r43.JerkConnection then
                    v5 = r43.JerkConnection;
                    v5.Disconnect(v5);
                    r43.JerkConnection = nil;
                end;
                r38("Jerk", "\xd0\x92\xd1\x8b\xd0\xba\xd0\xbb\xd1\x8e\xd1\x87\xd0\xb5\xd0\xbd", 2);
                return;
            end; 
        end;
        local function r69(...)
            r43.FlyRunning = false;
            if r43.FlyBodyGyro then
                pcall(function(...)
                    v5 = r43.FlyBodyGyro;
                    v5.Destroy(v5);
                    return; 
                end);
                r43.FlyBodyGyro = nil;
            end;
            if r43.FlyBodyVelocity then
                pcall(function(...)
                    v5 = r43.FlyBodyVelocity;
                    v5.Destroy(v5);
                    return; 
                end);
                r43.FlyBodyVelocity = nil;
            end;
            v1 = r34.Character;
            v3 = v1;
            if v1 then
                v1 = r34.Character;
                v3 = v1.FindFirstChild(v1, "Humanoid");
            end;
            if v3 then
                r34.Character.Humanoid.PlatformStand = false;
            end;
            r43.FlyKeys = {
                ["F"] = 0,
                ["B"] = 0,
                ["L"] = 0,
                ["R"] = 0
            };
            return; 
        end;
        Qh[28] = "\xaa\x84\"\xa5\x0bjX.[+";
        local function r70(...)
            if r43.FlyRunning then
                return;
            end;
            v1 = r34.Character;
            if not v1 then
                return;
            end;
            j = v1.FindFirstChild(v1, "Torso") or v1.FindFirstChild(v1, "UpperTorso");
            if not j then
                return;
            end;
            r43.FlyRunning = true;
            r43.FlyKeys = {
                ["F"] = 0,
                ["B"] = 0,
                ["L"] = 0,
                ["R"] = 0
            };
            r43.FlyBodyGyro = Instance.new("BodyGyro", j);
            r43.FlyBodyGyro.P = 90000;
            r43.FlyBodyGyro.maxTorque = Vector3.new(9000000000, 9000000000, 9000000000);
            r43.FlyBodyGyro.cframe = j.CFrame;
            r43.FlyBodyVelocity = Instance.new("BodyVelocity", j);
            r43.FlyBodyVelocity.velocity = Vector3.new(0, .1, 0);
            r43.FlyBodyVelocity.maxForce = Vector3.new(9000000000, 9000000000, 9000000000);
            v1.Humanoid.PlatformStand = true;
            r45(r43.FlyConn);
            H = r25.RenderStepped;
            r43.FlyConn = H.Connect(H, function(...)
                if not r43.FlyRunning or not r34.Character then
                    r69();
                    return;
                end;
                v1 = workspace.CurrentCamera;
                j = v1.CFrame.LookVector;
                H = v1.CFrame.RightVector;
                e = Vector3.new((r43.FlyKeys.R - r43.FlyKeys.L) * H.v2 + (r43.FlyKeys.F - r43.FlyKeys.B) * j.v2, (r43.FlyKeys.R - r43.FlyKeys.L) * H.v3 + (r43.FlyKeys.F - r43.FlyKeys.B) * j.v3, (r43.FlyKeys.R - r43.FlyKeys.L) * H.Z + (r43.FlyKeys.F - r43.FlyKeys.B) * j.Z) * r42.FlySpeed;
                Q = 0;
                if e.Magnitude > Q then
                    Q = Vector3.new((r43.FlyKeys.R - r43.FlyKeys.L) * H.v2 + (r43.FlyKeys.F - r43.FlyKeys.B) * j.v2, (r43.FlyKeys.R - r43.FlyKeys.L) * H.v3 + (r43.FlyKeys.F - r43.FlyKeys.B) * j.v3, (r43.FlyKeys.R - r43.FlyKeys.L) * H.Z + (r43.FlyKeys.F - r43[r15[r16("m=\"\xaa\xa6%n", T)]][r15[r16(k, i)]]) * j[P]) * r42[r15[r16("\xc2\xc8\x16\xd5F\xfd\x92\xf1", v6)]];
                    r43.FlyBodyVelocity.velocity = Q;
                else
                    r43.FlyBodyVelocity.velocity = Vector3.new(0, .1, 0);
                end;
                r43.FlyBodyGyro.cframe = v1.CFrame;
                return; 
            end);
            r38("Fly", "\xd0\x92\xd0\xba\xd0\xbb\xd1\x8e\xd1\x87\xd0\xb5\xd0\xbd (WASD - \xd0\xb4\xd0\xb2\xd0\xb8\xd0\xb6\xd0\xb5\xd0\xbd\xd0\xb8\xd0\xb5)", 2);
            return; 
        end;
        Qh[7] = 29444549031311;
        local function r71(arg1_15, ...)
            v1 = arg1_15;
            r42.FlyEnabled = v1;
            if v1 then
                r70();
            else
                r69();
            end;
            return; 
        end;
        (function(...)
            r45(r43.FlyKeyConn);
            r43.FlyKeyConn = nil;
            v1 = r27.InputBegan;
            r43.FlyKeyConn = v1.Connect(v1, function(arg1_16, arg2_16, ...)
                if arg2_16 then
                    return;
                end;
                if not r43.FlyRunning then
                    return;
                end;
                H = arg1_16.KeyCode;
                if H == Enum.KeyCode.W then
                    r43.FlyKeys.F = 1;
                else
                    if H == Enum.KeyCode.S then
                        r43.FlyKeys.B = 1;
                    else
                        if v1.KeyCode == Enum.KeyCode.A then
                            r43.FlyKeys.L = 1;
                        else
                            if v1.KeyCode == Enum.KeyCode.D then
                                r43.FlyKeys.R = 1;
                            end;
                            return;
                        end;
                    end;
                end; 
            end);
            r45(r43.FlyKeyEndConn);
            r43.FlyKeyEndConn = nil;
            v1 = r27.InputEnded;
            r43.FlyKeyEndConn = v1.Connect(v1, function(arg1_17, arg2_17, ...)
                if arg2_17 then
                    return;
                end;
                if not r43.FlyRunning then
                    return;
                end;
                H = arg1_17.KeyCode;
                if H == Enum.KeyCode.W then
                    r43.FlyKeys.F = 0;
                else
                    if H == Enum.KeyCode.S then
                        r43.FlyKeys.B = 0;
                    else
                        if v1.KeyCode == Enum.KeyCode.A then
                            r43.FlyKeys.L = 0;
                        else
                            if v1.KeyCode == Enum.KeyCode.D then
                                r43.FlyKeys.R = 0;
                            end;
                            return;
                        end;
                    end;
                end; 
            end);
            return; 
        end)();
        local function r72(...)
            r43.BHopActive = false;
            if r43.BHopConn then
                v5 = r43.BHopConn;
                v5.Disconnect(v5);
                r43.BHopConn = nil;
            end;
            if r43.BHopBV then
                pcall(function(...)
                    v5 = r43.BHopBV;
                    v5.Destroy(v5);
                    return; 
                end);
                r43.BHopBV = nil;
            end;
            return; 
        end;
        local function r73(...)
            if not r34.Character then
                return;
            end;
            if r43.BHopActive then
                r72();
            end;
            v1 = r34.Character;
            e = not v1.FindFirstChildOfClass(v1, "Humanoid");
            v3 = e;
            if e then
                if v3 then
                    return;
                end;
                r43.BHopActive = true;
                if r43.BHopBV then
                    pcall(function(...)
                        v5 = r43.BHopBV;
                        v5.Destroy(v5);
                        return; 
                    end);
                    r43.BHopBV = nil;
                end;
                r43.BHopBV = Instance.new("BodyVelocity");
                r43.BHopBV.Name = "BHopBV";
                r43.BHopBV.MaxForce = Vector3.new(100000, 0, 100000);
                r43.BHopBV.Velocity = Vector3.new(0, 0, 0);
                e = v5;
                r43.BHopBV.Parent = e;
                r74 = 0;
                r75 = .15;
                if r43.BHopConn then
                    v5 = r43.BHopConn;
                    v5.Disconnect(v5);
                    r43.BHopConn = nil;
                end;
                v4 = r25.Stepped;
                r43.BHopConn = v4.Connect(v4, function(...)
                    if not r43.BHopActive then
                        r72();
                        return;
                    end;
                    v1 = r34.Character;
                    if not v1 then
                        return;
                    end;
                    e = not v1.FindFirstChildOfClass(v1, "Humanoid");
                    v3 = e;
                    if e then
                        if v3 then
                            return;
                        end;
                        e = not r43.BHopBV;
                        if e or not r43.BHopBV.Parent then
                            r43.BHopBV = Instance.new("BodyVelocity");
                            r43.BHopBV.Name = "BHopBV";
                            r43.BHopBV.MaxForce = Vector3.new(100000, 0, 100000);
                            r43.BHopBV.Velocity = Vector3.new(0, 0, 0);
                            e = r43.BHopBV;
                            r43.BHopBV.Parent = e;
                        end;
                        e = j.MoveDirection;
                        v4 = j.GetState(j);
                        v2 = v4 == Enum.HumanoidStateType.Running or (v4 == Enum.HumanoidStateType.Landed or v4 == Enum.HumanoidStateType.RunningNoPhysics);
                        if e.Magnitude > .1 then
                            v7 = Vector3.new(e.v2, 0, e.Z);
                            if v7.Magnitude > .01 then
                                r43.BHopBV.Velocity = v7.Unit * r42.BHopSpeed;
                            end;
                            if v2 then
                                v3 = tick() - r74 > r75;
                            end;
                            if v2 then
                                j.ChangeState(j, Enum.HumanoidStateType.Jumping);
                                r74 = tick();
                            end;
                        else
                            r43.BHopBV.Velocity = Vector3.new(0, 0, 0);
                        end;
                        return;
                    else
                        v3 = not v1.FindFirstChild(v1, "HumanoidRootPart");
                    end; 
                end);
                r38("BHop", "\xd0\x92\xd0\xba\xd0\xbb\xd1\x8e\xd1\x87\xd0\xb5\xd0\xbd", 2);
                return;
            else
                v3 = not v1.FindFirstChild(v1, "HumanoidRootPart");
            end; 
        end;
        Qh[9] = 24351947222091;
        local function r76(arg1_18, ...)
            v1 = arg1_18;
            r42.BHopEnabled = v1;
            if v1 then
                r73();
            else
                r72();
            end;
            return; 
        end;
        r77 = {
            ["Enabled"] = false,
            ["Speed"] = 9999
        };
        local function r78(...)
            if r43.SpinConn then
                v5 = r43.SpinConn;
                v5.Disconnect(v5);
                r43.SpinConn = nil;
            end;
            if not r77.Enabled then
                return;
            end;
            v1 = r25.Heartbeat;
            r43.SpinConn = v1.Connect(v1, function(arg1_19, ...)
                if not r34.Character then
                    return;
                end;
                v5 = r34.Character;
                j = v5.FindFirstChild(v5, "HumanoidRootPart");
                if j then
                    j.CFrame = j.CFrame * CFrame.Angles(0, math.rad(r77.Speed * arg1_19), 0);
                end;
                return; 
            end);
            return; 
        end;
        local function r79(arg1_20, ...)
            v1 = arg1_20;
            j = v1;
            r77.Enabled = j;
            r78();
            v5 = r38;
            e = v5;
            v5 = v5;
            if v1 then
                v5 = v5;
                v5("Spin Bot", v1 and "\xd0\x92\xd0\xba\xd0\xbb\xd1\x8e\xd1\x87\xd0\xb5\xd0\xbd", 2);
                return;
            else
                H = "\xd0\x92\xd1\x8b\xd0\xba\xd0\xbb\xd1\x8e\xd1\x87\xd0\xb5\xd0\xbd";
            end; 
        end;
        local function r80(...)
            if r43.OrbizFolder then
                v5 = r43.OrbizFolder;
                v5.Destroy(v5);
                r43.OrbizFolder = nil;
            end;
            if r43.OrbizConnection then
                v5 = r43.OrbizConnection;
                v5.Disconnect(v5);
                r43.OrbizConnection = nil;
            end;
            r43.OrbizParticles = {};
            if not r42.OrbizEnabled then
                return;
            end;
            v1 = r34.Character;
            if not v1 then
                return;
            end;
            r81 = v1.FindFirstChild(v1, "HumanoidRootPart");
            if not r81 then
                return;
            end;
            H = Instance.new("Folder");
            H.Name = "Orbiz3D";
            H.Parent = workspace;
            r43.OrbizFolder = H;
            Q = 800;
            for I = 1, Q do
                w = Instance.new("Part");
                w.Shape = Enum.PartType.Ball;
                w.Size = Vector3.new(.2 + math.random() * .3, .2 + math.random() * .3, .2 + math.random() * .3);
                w.BrickColor = BrickColor.new("Bright violet");
                w.Material = Enum.Material.Neon;
                w.Transparency = .2 + math.random() * 0.5;
                w.Anchored = true;
                w.CanCollide = false;
                v3 = Instance.new("Folder");
                w.Parent = v3;
                w.Position = r81.Position + Vector3.new((math.random() - 0.5) * 80 * 2, math.random() * 50 + 20, (math.random() - 0.5) * 80 * 2);
                table.insert(r43.OrbizParticles, {
                    ["part"] = w,
                    ["speed"] = .2 + math.random() * .8,
                    ["driftX"] = (math.random() - 0.5) * 0.5,
                    ["driftZ"] = (math.random() - 0.5) * 0.5,
                    ["startY"] = w.Position.v3
                }); 
            end;
            Q = r25.Heartbeat;
            r43.OrbizConnection = Q.Connect(Q, function(...)
                v4 = "\xe9\x12\x8f\t\x87\xd57r\x9e\xc6\xec\x7f";
                v5 = not r42[r15[r16(v4, 3688906311349)]];
                if v5 then
                    return;
                end;
                H = r81;
                if H then
                    v1 = r81.Position;
                end;
                v5 = v5;
                v3 = H;
                if H then
                    j = 80;
                    v1 = v1;
                    v4 = r43;
                    v7 = r15;
                    Q = v4.OrbizParticles;
                    e = v4[3];
                    H = v4[2];
                    for e, v2 in pairs("pairs") do
                        v4 = e;
                        v7 = v2.part;
                        if not v7 or not v7.Parent then
                            
                        else
                            y = v7.Position - Vector3.new(0, v2.speed * .08, 0);
                            y = y + Vector3.new(v2.driftX * .03, 0, v2.driftZ * .03);
                            if y.v3 < v1.v3 - 10 then
                                y = Vector3.new(v1.v2 + (math.random() - 0.5) * 80 * 2, v1.v3 + 30 + math.random() * 40, v1.Z + (math.random() - 0.5) * 80 * 2);
                                v5.Transparency = .2 + math.random() * 0.5;
                                v5.Size = Vector3.new(.2 + math.random() * .4, .2 + math.random() * .4, .2 + math.random() * .4);
                            end;
                            v7.Position = y;
                        end; 
                    end;
                    return;
                else
                    v3 = Vector3.new(0, 0, 0);
                end; 
            end);
            return; 
        end;
        local function r82(arg1_21, ...)
            v1 = arg1_21;
            j = v1;
            r42.OrbizEnabled = j;
            r80();
            v5 = r38;
            v4 = v5;
            if v1 then
                Q = "\xd0\x92\xd0\xba\xd0\xbb\xd1\x8e\xd1\x87\xd0\xb5\xd0\xbd\xd1\x8b";
            end;
            v5 = v4;
            v5 = v5;
            v5("\xd0\x9e\xd1\x80\xd0\xb1\xd0\xb8\xd0\xb7\xd1\x8b", v1 or "\xd0\x92\xd1\x8b\xd0\xba\xd0\xbb\xd1\x8e\xd1\x87\xd0\xb5\xd0\xbd\xd1\x8b", 2);
            return; 
        end;
        local function r83(arg1_22, ...)
            v1 = arg1_22;
            if not v1 or not v1.Character then
                return false;
            end;
            j = v1.Character;
            v4 = j.GetDescendants;
            Q = {
                v4(j)
            };
            e = v4[3];
            Q = v4[1];
            for e, v2 in Q, ipairs(C(Q)) do
                v4 = e;
                v7 = v2.IsA(v2, "Tool") or (v2.IsA(v2, "Part") or v2.IsA(v2, "MeshPart"));
                if v7 then
                    v5 = v2.Name;
                    v7 = v5.lower(v5);
                    if v7.find(v7, "knife") or (v7.find(v7, "blade") or (v7.find(v7, "dagger") or (v7.find(v7, "murder") or v7.find(v7, "butcher")))) then
                        return true;
                    else
                        
                    end;
                end; 
            end;
            H = v1.FindFirstChild(v1, "Backpack");
            if H then
                v5 = ipairs;
                v7 = H.GetChildren;
                v4 = v7[3];
                for v4, v7 in v7[1], v5(v7(H)) do
                    v2 = v4;
                    v5 = v7.Name;
                    y = v5.lower(v5);
                    if y.find(y, "knife") or (y.find(y, "blade") or (y.find(y, "dagger") or (y.find(y, "murder") or y.find(y, "butcher")))) then
                        return true;
                    else
                        
                    end; 
                end;
            end;
            return false; 
        end;
        local function r84(...)
            Vector2.new(r35.ViewportSize.v2 / 2, r35.ViewportSize.v3 / 2);
            H = math.huge;
            v4 = r24;
            e = v4[2];
            v4 = v4[1];
            for Q, v7 in ipairs(v4.GetPlayers(v4)) do
                v2 = Q;
                if v7 == r34 then
                    
                else
                    if not v7.Character then
                        
                    else
                        if not r83(v7) then
                            
                        else
                            v5 = v7.Character;
                            J = r16;
                            y = v5.FindFirstChild(v5, "HumanoidRootPart");
                            if not y then
                                
                            else
                                v5 = r35;
                                J = {
                                    v5.WorldToScreenPoint(v5, y.Position)
                                };
                                w = v5.WorldToScreenPoint(v5, y.Position);
                                v6 = J[2];
                                if not v6 then
                                    
                                else
                                    v5 = (Vector2.new(w.v2, w.v3) - Vector2.new(r35.ViewportSize.v2 / 2, r35[r15[r16("\x8eU*\xad\xbf\xc89\x1f\x98\xf5g\x1f", v6)]][r15[r16(y, w)]] / 2)).Magnitude;
                                    if v5 <= r42.SilentAimFov and v5 < math.huge then
                                        v5 = v5;
                                        H = v5;
                                        j = v7;
                                    end;
                                end;
                            end;
                        end;
                    end;
                end; 
            end;
            return nil; 
        end;
        local function r85(...)
            H = r33;
            j = H[3];
            v1 = H[2];
            H = "ipairs";
            for j, Q in ipairs(H.GetDescendants(H)) do
                e = j;
                v4 = Q.IsA(Q, "RemoteEvent") or Q.IsA(Q, "RemoteFunction");
                if v4 then
                    v5 = Q.Name;
                    v4 = v5.lower(v5);
                    if v4.find(v4, "attack") or (v4.find(v4, "slash") or (v4.find(v4, "stab") or (v4.find(v4, "kill") or (v4.find(v4, "damage") or (v4.find(v4, "hit") or (v4.find(v4, "click") or v4.find(v4, "swing"))))))) then
                        return Q;
                    else
                        
                    end;
                end; 
            end;
            e = r33;
            Q = {
                e.GetDescendants(e)
            };
            v1 = e[1];
            j = e[2];
            for H, Q in ipairs(C(Q)) do
                e = H;
                if Q.IsA(Q, "RemoteEvent") then
                    return Q;
                else
                    
                end; 
            end;
            return nil; 
        end;
        Qh[25] = 16735184969328;
        r86 = r85();
        local function r87(arg1_23, ...)
            v1 = arg1_23;
            if not v1 or not v1.Character then
                return nil;
            end;
            v5 = v1.Character;
            j = v5.FindFirstChild(v5, "HumanoidRootPart");
            if not j then
                return nil;
            end;
            return j.Position + j.AssemblyLinearVelocity * .15; 
        end;
        local function r88(...)
            if not r42.SilentAimEnabled then
                return;
            end;
            if not r34.Character then
                return;
            end;
            if not r83(r34) then
                return;
            end;
            r89 = r84();
            if not r89 then
                return;
            end;
            r90 = r87(r89);
            if not r90 then
                return;
            end;
            if not r86 then
                r86 = r85();
                if not r86 then
                    return;
                end;
            end;
            v5 = r34.Character;
            H = v5.FindFirstChild(v5, "HumanoidRootPart");
            if not H then
                return;
            end;
            r91 = (r90 - H.Position).Unit;
            pcall(function(...)
                v5 = r86;
                v5.FireServer(v5, r90, r89.Character);
                v5 = r86;
                v5.FireServer(v5, r89);
                v5 = r89.Character;
                v1 = v5.FindFirstChild(v5, "HumanoidRootPart");
                if v1 then
                    v5 = r86;
                    v5.FireServer(v5, v1);
                end;
                v5 = r86;
                v5.FireServer(v5, r91);
                v5 = r86;
                v5.FireServer(v5, r89.Character.HumanoidRootPart.Position, r89);
                v5 = r86;
                v5.FireServer(v5, r89.Character.HumanoidRootPart, r89);
                return; 
            end);
            return; 
        end;
        local function r92(...)
            if r43.SilentAimCircle then
                pcall(function(...)
                    v5 = r43.SilentAimCircle;
                    v5.Remove(v5);
                    return; 
                end);
                r43.SilentAimCircle = nil;
            end;
            v1 = Drawing.new("Circle");
            v1.Radius = r42.SilentAimFov;
            v1.Color = Color3.fromRGB(0, 255, 0);
            v1.Thickness = 1.5;
            v1.Transparency = .6;
            v1.Filled = false;
            v1.Visible = false;
            v1.NumSides = 64;
            r43.SilentAimCircle = v1;
            return; 
        end;
        local function r94(...)
            if r93 then
                v5 = r93;
                v5.Disconnect(v5);
            end;
            if not r42.SilentAimEnabled then
                return;
            end;
            v3 = r27.InputBegan;
            r93 = v3.Connect(v3, function(arg1_24, arg2_24, ...)
                if arg2_24 then
                    return;
                end;
                if arg1_24.UserInputType == Enum.UserInputType.MouseButton1 then
                    r88();
                end;
                return; 
            end);
            return; 
        end;
        local function r95(arg1_25, ...)
            v1 = arg1_25;
            r42.SilentAimEnabled = v1;
            if v1 then
                r92();
                r94();
                j = r43;
                if not j.SilentAimConn then
                    j = r25.RenderStepped;
                    r43.SilentAimConn = j.Connect(j, function(...)
                        if not r42.SilentAimEnabled then
                            if r43.SilentAimCircle then
                                r43.SilentAimCircle.Visible = false;
                            end;
                            return;
                        end;
                        v1 = r43.SilentAimCircle;
                        if not v1 then
                            return;
                        end;
                        v3 = Vector2.new(r35.ViewportSize.v2 / 2, r35.ViewportSize.v3 / 2);
                        v1.Position = v3;
                        v1.Radius = r42.SilentAimFov;
                        v1.Visible = true;
                        H = r84();
                        if H then
                            v1.Color = Color3.fromRGB(255, 50, 50);
                        else
                            v1.Color = Color3.fromRGB(0, 255, 0);
                        end;
                        return; 
                    end);
                end;
                r38("Silent Aim", "\xd0\x92\xd0\xba\xd0\xbb\xd1\x8e\xd1\x87\xd0\xb5\xd0\xbd (\xd0\xbd\xd0\xb0\xd0\xb2\xd0\xbe\xd0\xb4\xd0\xb8\xd1\x82\xd1\x81\xd1\x8f \xd0\xbd\xd0\xb0 \xd1\x81\xd0\xb5\xd1\x80\xd0\xb2\xd0\xb5\xd1\x80)", 2);
            else
                if r93 then
                    v5 = r93;
                    v5.Disconnect(v5);
                end;
                if r43.SilentAimConn then
                    v3 = r43.SilentAimConn;
                    v3.Disconnect(v3);
                    r43.SilentAimConn = nil;
                end;
                if r43.SilentAimCircle then
                    r43.SilentAimCircle.Visible = false;
                end;
                r38("Silent Aim", "\xd0\x92\xd1\x8b\xd0\xba\xd0\xbb\xd1\x8e\xd1\x87\xd0\xb5\xd0\xbd", 2);
                return;
            end; 
        end;
        local function r96(...)
            H = r33;
            j = H[3];
            H = H[1];
            for j, Q in H, ipairs(H.GetDescendants(H)) do
                e = j;
                v4 = "RemoteEvent";
                v5 = Q.IsA(Q, v4);
                if v5 then
                    v5 = Q.Name;
                    v4 = v5.lower(v5);
                    if v4.find(v4, "kill") or (v4.find(v4, "attack") or (v4.find(v4, "damage") or (v4.find(v4, "murder") or (v4.find(v4, "slash") or v4.find(v4, "stab"))))) then
                        r43.KillAllRemote = Q;
                        return;
                    else
                        
                    end;
                end; 
            end;
            e = r33;
            Q = {
                e.GetDescendants(e)
            };
            H = e[3];
            for H, Q in e[1], ipairs(C(Q)) do
                e = H;
                if Q.IsA(Q, "RemoteEvent") then
                    r43.KillAllRemote = Q;
                    return;
                else
                    
                end; 
            end;
            return; 
        end;
        r96();
        local function r97(...)
            if not r43.KillAllRemote then
                return;
            end;
            H = r24;
            j = H[3];
            H = H[1];
            for j, Q in H, ipairs(H.GetPlayers(H)) do
                e = j;
                r98 = Q;
                if A[v5] ~= r34 and (A[v5].Character and 12.FindFirstChild(12, "Humanoid")) then
                    pcall(function(...)
                        v5 = r43.KillAllRemote;
                        v5.FireServer(v5, A[v5]);
                        v5 = r43.KillAllRemote;
                        v5.FireServer(v5, A[v5].Character);
                        v5 = r43.KillAllRemote;
                        v5.FireServer(v5, A[v5].Character.HumanoidRootPart);
                        return; 
                    end);
                end; 
            end;
            return; 
        end;
        local function r99(...)
            r45(r43.KillAllConn);
            r43.KillAllConn = nil;
            if not r42.KillAllEnabled then
                return;
            end;
            v1 = r25.Stepped;
            r43.KillAllConn = v1.Connect(v1, function(...)
                if r42.KillAllEnabled then
                    r97();
                end;
                return; 
            end);
            return; 
        end;
        local function r100(arg1_26, ...)
            v1 = arg1_26;
            r42.KillAllEnabled = v1;
            if v1 then
                if not r43.KillAllRemote then
                    r96();
                end;
                r99();
                r38("Kill All", "\xd0\x92\xd0\xba\xd0\xbb\xd1\x8e\xd1\x87\xd0\xb5\xd0\xbd (\xd0\xbd\xd1\x83\xd0\xb6\xd0\xbd\xd0\xb0 \xd1\x80\xd0\xbe\xd0\xbb\xd1\x8c \xd1\x83\xd0\xb1\xd0\xb8\xd0\xb9\xd1\x86\xd1\x8b)", 2);
            else
                r45(r43.KillAllConn);
                r43.KillAllConn = nil;
                r38("Kill All", "\xd0\x92\xd1\x8b\xd0\xba\xd0\xbb\xd1\x8e\xd1\x87\xd0\xb5\xd0\xbd", 2);
            end;
            return; 
        end;
        Qh[3] = 30718532368352;
        Qh[1] = 11994178950609;
        Qh[22] = "g-~\xe2d\xe3\r'\xbd}";
        Qh[55] = 34234676051525;
        Qh[11] = 11801074013559;
        Qh[10] = "\xc3$\xc2\x9f\x0f\x12Y~@";
        Qh[2] = "OO\xf1=\xb3\x95\xc7\xa1\xb4";
        Qh[35] = 11423551198407;
        Qh[1] = 27740153770613;
        Qh[5] = 14583619558023;
        Qh[1] = r16(Qh[2], Qh[3]);
        Qh[24] = "e\x82~#\xbf\x97\x1e\xa5\xfb5";
        Qh[53] = 27908144263875;
        Qh[43] = 2472690992255;
        Qh[3] = 4393052964861;
        Qh[2] = "\x88uf\xdc\x9b\x9b\xf0\x18\x83\x90";
        Qh[13] = 8973598183506;
        Qh[52] = 8147943280338;
        Qh[1] = 22223025219692;
        Qh[1] = r16(Qh[2], Qh[3]);
        Qh[1] = r15;
        Qh[2] = r16;
        Qh[3] = Qh[2](Qh[4], Qh[5]);
        Qh[1] = 97824616490448;
        Qh[48] = 15148696050574;
        Qh[2] = "C`\xd9a\x12]\x8b!";
        Qh[4] = "\x17\xb2\xdf(";
        Qh[3] = 12296343541341;
        Qh[32] = "\x0c9\xa0\t\xde)\xe2y\x9bo";
        Qh[16] = "\xf3`$\xce.\xa7!\x93\xbe?";
        Qh[19] = 1292468273753;
        Qh[1] = 22721309239636;
        Qh[5] = 18329944809815;
        Qh[1] = r16(Qh[2], Qh[3]);
        Qh[1] = r15;
        Qh[2] = r16;
        Qh[3] = Qh[2](Qh[4], Qh[5]);
        Qh[15] = 34159275572770;
        Qh[3] = r15;
        Qh[4] = r16;
        Qh[1] = 99384245425157;
        Qh[5] = Qh[4](Qh[6], Qh[7]);
        Qh[2] = Qh[3][Qh[5]];
        Qh[46] = 1622616965875;
        Qh[3] = 76049494037641;
        Qh[7] = 12662204274440;
        Qh[1] = 23260185029199;
        Qh[5] = 28802539418724;
        Qh[6] = "\xa0\t\xed\xec\x05u\x07\n.J";
        Qh[8] = "\xeb\xf1!Y3\xa5e\xaa|)";
        Qh[12] = "\xeb\xaaj\xc9k\x0e\x8b\xf4\xfc\xe7";
        Qh[3] = 31796165556694;
        Qh[26] = "1\xf7h\x0c1\xdb\xa7m\xea0";
        Qh[2] = "<c\x04\xa9";
        Qh[17] = 5266130520468;
        Qh[4] = "\xa7\xd9Pd\x92\x0e\x07\x8bd";
        Qh[1] = r16(Qh[2], Qh[3]);
        Qh[1] = r15;
        Qh[2] = r16;
        Qh[3] = Qh[2](Qh[4], Qh[5]);
        Qh[1] = 10921100400;
        Qh[3] = r15;
        Qh[4] = r16;
        Qh[5] = Qh[4](Qh[6], Qh[7]);
        Qh[2] = Qh[3][Qh[5]];
        Qh[3] = 10921101664;
        Qh[5] = r15;
        Qh[6] = r16;
        Qh[7] = Qh[6](Qh[8], Qh[9]);
        Qh[4] = Qh[5][Qh[7]];
        Qh[5] = 10921102574;
        Qh[2] = "xJZ\xc6\\\xbe\xe9\xee";
        Qh[7] = 22228208953454;
        Qh[1] = 17648381845530;
        Qh[9] = 25505424043620;
        Qh[5] = 7408021048697;
        Qh[6] = "\\\xa2\\I^J\x06\xf5\x13\x9b";
        Qh[39] = 31298756262126;
        Qh[3] = 3282398807544;
        Qh[23] = 19175042278113;
        Qh[30] = "=\x95\xdd\xe7\xe5v-g\xe1\xaa";
        Qh[4] = "\x0e\x86\xe4A";
        Qh[8] = "\xb5\xaeKiv\x8e\xcf\xee\x14\xbc";
        Qh[1] = r16(Qh[2], Qh[3]);
        Qh[40] = ",T\xa3\xad";
        Qh[18] = "7\xa0\xfeC\xe9\xb2&\x94\x7fW";
        Qh[1] = r15;
        Qh[2] = r16;
        Qh[3] = Qh[2](Qh[4], Qh[5]);
        Qh[3] = r15;
        Qh[4] = r16;
        Qh[1] = 10921352344;
        Qh[5] = Qh[4](Qh[6], Qh[7]);
        Qh[2] = Qh[3][Qh[5]];
        Qh[5] = r15;
        Qh[3] = 10921344533;
        Qh[6] = r16;
        Qh[7] = Qh[6](Qh[8], Qh[9]);
        Qh[29] = 14072779463065;
        Qh[4] = Qh[5][Qh[7]];
        Qh[7] = r15;
        Qh[5] = 10921345304;
        Qh[8] = r16;
        Qh[9] = Qh[8](Qh[10], Qh[11]);
        Qh[6] = Qh[7][Qh[9]];
        Qh[7] = 10921343576;
        Qh[5] = 14001257257335;
        Qh[3] = 20420751156517;
        Qh[1] = 18673565802999;
        Qh[9] = 7957688307321;
        Qh[6] = "\xc5\xd8\x01\x86";
        Qh[7] = 25828025478907;
        Qh[20] = "\xd2\xedoE|N\xc2\xc9\x8cX";
        Qh[2] = "\x9a\xa0i\x95|d:\xdc";
        Qh[1] = r16(Qh[2], Qh[3]);
        Qh[1] = r15;
        Qh[8] = "\x0b?_\x8d\x97\x03\xe3\xb1\xfe";
        Qh[2] = r16;
        Qh[4] = "\x13\xca\xf7\xfaM\xcf\xd8t";
        Qh[3] = Qh[2](Qh[4], Qh[5]);
        Qh[3] = r15;
        Qh[1] = 10921151661;
        Qh[10] = "\xebp\x82r\xe5\x88J\x92\xe7\xfa";
        Qh[4] = r16;
        Qh[5] = Qh[4](Qh[6], Qh[7]);
        Qh[2] = Qh[3][Qh[5]];
        Qh[3] = 10921150788;
        Qh[5] = r15;
        Qh[6] = r16;
        Qh[7] = Qh[6](Qh[8], Qh[9]);
        Qh[4] = Qh[5][Qh[7]];
        Qh[7] = r15;
        Qh[5] = 10921143404;
        Qh[11] = 26297600798677;
        Qh[8] = r16;
        Qh[9] = Qh[8](Qh[10], Qh[11]);
        Qh[6] = Qh[7][Qh[9]];
        Qh[9] = r15;
        Qh[27] = 21108326377061;
        Qh[7] = 10921144709;
        Qh[10] = r16;
        Qh[11] = Qh[10](Qh[12], Qh[13]);
        Qh[8] = Qh[9][Qh[11]];
        Qh[11] = 1200839918127;
        Qh[9] = 10921145797;
        Qh[7] = 27326603751860;
        Qh[8] = "\x81\x82\xc21";
        Qh[5] = 4589046450264;
        Qh[1] = 14289440430590;
        Qh[6] = "\xe7U\xf8Y\xd3o\xa2\x8a";
        Qh[42] = "\x08}\x1e\x89";
        Qh[9] = 21497071298330;
        Qh[14] = "\xfc\xf2j\x9e6\n\x9dWj\x1e";
        Qh[3] = 33421258357962;
        Qh[13] = 20944771065369;
        Qh[2] = "y\xb8\xeeV\xf6E\x9c\xbf";
        Qh[4] = "\x9f\xd3\xb3\xc1(H\xf1\t";
        Qh[10] = "i\xef\x0e\xedu\xdb\x9b\x1e\xe5";
        Qh[1] = r16(Qh[2], Qh[3]);
        Qh[1] = r15;
        Qh[2] = r16;
        Qh[3] = Qh[2](Qh[4], Qh[5]);
        Qh[54] = 9144200532130;
        Qh[3] = r15;
        Qh[1] = 92294537340807;
        Qh[4] = r16;
        Qh[5] = Qh[4](Qh[6], Qh[7]);
        Qh[2] = Qh[3][Qh[5]];
        Qh[5] = r15;
        Qh[6] = r16;
        Qh[7] = Qh[6](Qh[8], Qh[9]);
        Qh[4] = Qh[5][Qh[7]];
        Qh[5] = 1.3459174318163e+14;
        Qh[3] = 98854111361360;
        Qh[37] = 7336120454488;
        Qh[7] = r15;
        Qh[12] = "F\x0f\xc5\xa3\x9cy\xc32\xaf$";
        Qh[8] = r16;
        Qh[9] = Qh[8](Qh[10], Qh[11]);
        Qh[6] = Qh[7][Qh[9]];
        Qh[9] = r15;
        Qh[10] = r16;
        Qh[11] = Qh[10](Qh[12], Qh[13]);
        Qh[7] = 1.1937722096755e+14;
        Qh[8] = Qh[9][Qh[11]];
        Qh[11] = r15;
        Qh[12] = r16;
        Qh[13] = Qh[12](Qh[14], Qh[15]);
        Qh[10] = Qh[11][Qh[13]];
        Qh[9] = 1.3380621499229e+14;
        Qh[11] = 94970088341563;
        Qh[1] = 10097098658397;
        Qh[15] = 19190716031720;
        Qh[8] = "\xce\xd6\xd6\x19\x97\xa7Q\x15";
        Qh[3] = 14498497337951;
        Qh[11] = 14945078582063;
        Qh[4] = "p\x93\x05\xb3\x0b\xea\t}";
        Qh[2] = "dl\x1dU\xac\xf5S";
        Qh[5] = 11662679774518;
        Qh[1] = r16(Qh[2], Qh[3]);
        Qh[1] = r15;
        Qh[13] = 4250982926267;
        Qh[2] = r16;
        Qh[14] = "U%\xca\xa2\xc5\x9esK\x15\x17";
        Qh[9] = 32146879183481;
        Qh[3] = Qh[2](Qh[4], Qh[5]);
        Qh[1] = 10921042494;
        Qh[6] = "\\\x1c\x9d\xe7\xab\x07\xfc\x1e";
        Qh[3] = r15;
        Qh[4] = r16;
        Qh[7] = 32027333982785;
        Qh[12] = "\xd7\xc7CK0\x1eD\xa0\xde";
        Qh[5] = Qh[4](Qh[6], Qh[7]);
        Qh[2] = Qh[3][Qh[5]];
        Qh[5] = r15;
        Qh[10] = "\xff\x10\xd4\x9d";
        Qh[6] = r16;
        Qh[3] = 10921040576;
        Qh[7] = Qh[6](Qh[8], Qh[9]);
        Qh[4] = Qh[5][Qh[7]];
        Qh[7] = r15;
        Qh[8] = r16;
        Qh[9] = Qh[8](Qh[10], Qh[11]);
        Qh[5] = 10921045006;
        Qh[6] = Qh[7][Qh[9]];
        Qh[9] = r15;
        Qh[10] = r16;
        Qh[7] = 10921044000;
        Qh[11] = Qh[10](Qh[12], Qh[13]);
        Qh[8] = Qh[9][Qh[11]];
        Qh[11] = r15;
        Qh[9] = 10921032124;
        Qh[12] = r16;
        Qh[13] = Qh[12](Qh[14], Qh[15]);
        Qh[10] = Qh[11][Qh[13]];
        Qh[13] = r15;
        Qh[11] = 10921034824;
        Qh[14] = r16;
        Qh[15] = Qh[14](Qh[16], Qh[17]);
        Qh[12] = Qh[13][Qh[15]];
        Qh[13] = 10921036806;
        Qh[1] = 16052056939826;
        Qh[6] = "\x0bq\xfaR\xca\xa0w\xb6";
        Qh[10] = "\xb6^\x05r\xaa\x85DZ";
        Qh[16] = "\xdc\xe01\xd3(\xb1VL\x0b\xea";
        Qh[12] = "\x1c|\xe7\x15";
        Qh[4] = " \xa1R\x00\x8d.\xa6";
        Qh[3] = 20818172437982;
        Qh[2] = "kk\xa4\xf0\x06\xa2K\x82";
        Qh[11] = 30007651448469;
        Qh[1] = r16(Qh[2], Qh[3]);
        Qh[9] = 4307366135765;
        Qh[1] = r15;
        Qh[14] = "\xd8i\xc6\xb0)\x03\x80F\xc0";
        Qh[5] = 9586900291952;
        Qh[13] = 10179239580292;
        Qh[2] = r16;
        Qh[3] = Qh[2](Qh[4], Qh[5]);
        Qh[1] = 1.3551545487797e+14;
        Qh[3] = r15;
        Qh[7] = 31362354428172;
        Qh[8] = "O\x17g\x11\x8e\\\xe5b";
        Qh[4] = r16;
        Qh[5] = Qh[4](Qh[6], Qh[7]);
        Qh[2] = Qh[3][Qh[5]];
        Qh[3] = 78508480717326;
        Qh[5] = r15;
        Qh[6] = r16;
        Qh[15] = 30135391614672;
        Qh[21] = 31301060851951;
        Qh[7] = Qh[6](Qh[8], Qh[9]);
        Qh[4] = Qh[5][Qh[7]];
        Qh[34] = "t\xd2\x9b>";
        Qh[5] = 78147885297412;
        Qh[7] = r15;
        Qh[8] = r16;
        Qh[9] = Qh[8](Qh[10], Qh[11]);
        Qh[6] = Qh[7][Qh[9]];
        Qh[7] = 1.2918312308328e+14;
        Qh[9] = r15;
        Qh[10] = r16;
        Qh[11] = Qh[10](Qh[12], Qh[13]);
        Qh[8] = Qh[9][Qh[11]];
        Qh[11] = r15;
        Qh[12] = r16;
        Qh[17] = 2780967650574;
        Qh[9] = 1.1065701392177e+14;
        Qh[13] = Qh[12](Qh[14], Qh[15]);
        Qh[10] = Qh[11][Qh[13]];
        Qh[11] = 1.2944749774482e+14;
        Qh[13] = r15;
        Qh[14] = r16;
        Qh[15] = Qh[14](Qh[16], Qh[17]);
        Qh[12] = Qh[13][Qh[15]];
        Qh[15] = r15;
        Qh[13] = 92849173543269;
        Qh[16] = r16;
        Qh[17] = Qh[16](Qh[18], Qh[19]);
        Qh[14] = Qh[15][Qh[17]];
        Qh[15] = 1.3223890095111e+14;
        Qh[8] = "\x9e1\xc8^s\\\xd3P";
        Qh[13] = 21285265925815;
        Qh[2] = "\x11\xd0\xfcT\xb8\xf3\xb3\x00";
        Qh[15] = 10356289770198;
        Qh[4] = "\x06\xe1\r%6*\xf0\xe1";
        Qh[6] = "\xb5\x87\xb4\n\xf65a";
        Qh[3] = 3924617692963;
        Qh[18] = "\xf1\xe5[I\t\xf4\xf3L\xae%";
        Qh[1] = r16(Qh[2], Qh[3]);
        Qh[1] = r15;
        Qh[2] = r16;
        Qh[5] = 4998832883991;
        Qh[3] = Qh[2](Qh[4], Qh[5]);
        Qh[7] = 16696219459166;
        Qh[9] = 18214058123553;
        Qh[16] = ".\xaf]\xa9F\x07\xaf\xbd=";
        Qh[1] = 10921342074;
        Qh[3] = r15;
        Qh[4] = r16;
        Qh[5] = Qh[4](Qh[6], Qh[7]);
        Qh[2] = Qh[3][Qh[5]];
        Qh[5] = r15;
        Qh[6] = r16;
        Qh[7] = Qh[6](Qh[8], Qh[9]);
        Qh[17] = 24732790451453;
        Qh[19] = 22486105843942;
        Qh[14] = "zI%:";
        Qh[3] = 10921336997;
        Qh[10] = "l\xdetQ\xd88:\xb2";
        Qh[4] = Qh[5][Qh[7]];
        Qh[5] = nil;
        Qh[11] = 3235719153122;
        Qh[7] = r15;
        Qh[8] = r16;
        Qh[9] = Qh[8](Qh[10], Qh[11]);
        Qh[6] = Qh[7][Qh[9]];
        Qh[9] = r15;
        Qh[7] = 10921337907;
        Qh[12] = "y\x80\x8fo\x1d\x00\x8e|";
        Qh[10] = r16;
        Qh[11] = Qh[10](Qh[12], Qh[13]);
        Qh[8] = Qh[9][Qh[11]];
        Qh[11] = r15;
        Qh[9] = 10921341319;
        Qh[12] = r16;
        Qh[13] = Qh[12](Qh[14], Qh[15]);
        Qh[10] = Qh[11][Qh[13]];
        Qh[13] = r15;
        Qh[14] = r16;
        Qh[11] = 10921340419;
        Qh[15] = Qh[14](Qh[16], Qh[17]);
        Qh[12] = Qh[13][Qh[15]];
        Qh[13] = 10921329322;
        Qh[15] = r15;
        Qh[16] = r16;
        Qh[17] = Qh[16](Qh[18], Qh[19]);
        Qh[14] = Qh[15][Qh[17]];
        Qh[15] = 10921330408;
        Qh[17] = r15;
        Qh[18] = r16;
        Qh[19] = Qh[18](Qh[20], Qh[21]);
        Qh[16] = Qh[17][Qh[19]];
        Qh[17] = 10921333667;
        Qh[19] = 4277907146696;
        Qh[1] = r15;
        Qh[15] = 3056749282703;
        Qh[16] = "\xd5\x1b\xb2\xfc";
        Qh[14] = "\x8b\x84\x0eV%\xe9+!";
        Qh[5] = 23707693919007;
        Qh[2] = r16;
        Qh[4] = "1\x00\rL\x04\x06\x92r\n";
        Qh[3] = Qh[2](Qh[4], Qh[5]);
        Qh[17] = 35168698351608;
        Qh[9] = 6213787405133;
        Qh[13] = 24517200653464;
        Qh[8] = "O\x05\x8e.\xd9`\xed";
        Qh[10] = "I\x82\xed\xce[\xe0 \x05";
        Qh[6] = "\xcf\xe1\xa2d\xdc\xb3\x97|";
        Qh[7] = 12854520878945;
        Qh[3] = r15;
        Qh[4] = r16;
        Qh[5] = Qh[4](Qh[6], Qh[7]);
        Qh[2] = Qh[3][Qh[5]];
        Qh[5] = r15;
        Qh[3] = 10921298616;
        Qh[20] = "\x11\"\xb81p\x7f\xdf\xd6\x17\x0c";
        Qh[12] = "\xc2\xaf\x84\x92}\x96b&";
        Qh[18] = "\x08Bg\xc7\xc5\x02U\xc4\xe8";
        Qh[6] = r16;
        Qh[11] = 3021819151743;
        Qh[7] = Qh[6](Qh[8], Qh[9]);
        Qh[4] = Qh[5][Qh[7]];
        Qh[7] = r15;
        Qh[5] = 10921291831;
        Qh[8] = r16;
        Qh[9] = Qh[8](Qh[10], Qh[11]);
        Qh[6] = Qh[7][Qh[9]];
        Qh[7] = 10921294559;
        Qh[9] = r15;
        Qh[10] = r16;
        Qh[11] = Qh[10](Qh[12], Qh[13]);
        Qh[8] = Qh[9][Qh[11]];
        Qh[9] = 10921293373;
        Qh[11] = r15;
        Qh[12] = r16;
        Qh[13] = Qh[12](Qh[14], Qh[15]);
        Qh[10] = Qh[11][Qh[13]];
        Qh[11] = 10921297391;
        Qh[21] = 7307732225354;
        Qh[13] = r15;
        Qh[14] = r16;
        Qh[15] = Qh[14](Qh[16], Qh[17]);
        Qh[12] = Qh[13][Qh[15]];
        Qh[13] = 10921295495;
        Qh[15] = r15;
        Qh[16] = r16;
        Qh[17] = Qh[16](Qh[18], Qh[19]);
        Qh[14] = Qh[15][Qh[17]];
        Qh[17] = r15;
        Qh[15] = 10921286911;
        Qh[18] = r16;
        Qh[19] = Qh[18](Qh[20], Qh[21]);
        Qh[16] = Qh[17][Qh[19]];
        Qh[17] = 10921288909;
        Qh[19] = r15;
        Qh[20] = r16;
        Qh[21] = Qh[20](Qh[22], Qh[23]);
        Qh[18] = Qh[19][Qh[21]];
        Qh[19] = 10921290167;
        Qh[1] = {
            [Qh[2]] = Qh[3],
            [Qh[4]] = Qh[5],
            [Qh[6]] = Qh[7],
            [Qh[8]] = Qh[9],
            [Qh[10]] = Qh[11],
            [Qh[12]] = Qh[13],
            [Qh[14]] = Qh[15],
            [Qh[16]] = Qh[17],
            [Qh[18]] = Qh[19]
        };
        Qh[10] = "\x9e\xfdr\x0b\xe0Eq";
        Qh[23] = 4067228288869;
        Qh[3] = r15;
        Qh[8] = "\xfdYh\x9c\x07\xf6i\xdb";
        Qh[9] = 23359789165181;
        Qh[22] = "\n/\x9f\x97\xb7B\xee\x10\x11E";
        Qh[6] = "3+\xe4";
        Qh[4] = r16;
        Qh[7] = 9544037667164;
        Qh[5] = Qh[4](Qh[6], Qh[7]);
        Qh[17] = 9116208763029;
        Qh[2] = Qh[3][Qh[5]];
        Qh[5] = r15;
        Qh[6] = r16;
        Qh[7] = Qh[6](Qh[8], Qh[9]);
        Qh[4] = Qh[5][Qh[7]];
        Qh[5] = 10921312010;
        Qh[11] = 4808842627263;
        Qh[21] = 29717011068430;
        Qh[13] = 19130937959116;
        Qh[33] = 7422382738816;
        Qh[7] = r15;
        Qh[12] = "\x1dnE\xcc?\xe1\x15\xea";
        Qh[8] = r16;
        Qh[9] = Qh[8](Qh[10], Qh[11]);
        Qh[20] = "R\xa68C\x0cq\x9fM\\";
        Qh[6] = Qh[7][Qh[9]];
        Qh[14] = "j\xb0\xcd\xbeC\xf0\xbc\xc3";
        Qh[7] = 10921306285;
        Qh[9] = r15;
        Qh[10] = r16;
        Qh[11] = Qh[10](Qh[12], Qh[13]);
        Qh[8] = Qh[9][Qh[11]];
        Qh[11] = r15;
        Qh[15] = 19537771488137;
        Qh[12] = r16;
        Qh[18] = "\xe4\xf8W8";
        Qh[13] = Qh[12](Qh[14], Qh[15]);
        Qh[16] = "\x12t\xefS\xbb\xd9a\xaa";
        Qh[10] = Qh[11][Qh[13]];
        Qh[11] = 10921307241;
        Qh[9] = 10921308158;
        Qh[13] = r15;
        Qh[14] = r16;
        Qh[15] = Qh[14](Qh[16], Qh[17]);
        Qh[12] = Qh[13][Qh[15]];
        Qh[15] = r15;
        Qh[13] = 10921310341;
        Qh[19] = 13954217318753;
        Qh[16] = r16;
        Qh[17] = Qh[16](Qh[18], Qh[19]);
        Qh[14] = Qh[15][Qh[17]];
        Qh[15] = 10921309319;
        Qh[17] = r15;
        Qh[18] = r16;
        Qh[19] = Qh[18](Qh[20], Qh[21]);
        Qh[16] = Qh[17][Qh[19]];
        Qh[17] = 10921300839;
        Qh[19] = r15;
        Qh[20] = r16;
        Qh[21] = Qh[20](Qh[22], Qh[23]);
        Qh[18] = Qh[19][Qh[21]];
        Qh[21] = r15;
        Qh[19] = 10921301576;
        Qh[22] = r16;
        Qh[23] = Qh[22](Qh[24], Qh[25]);
        Qh[20] = Qh[21][Qh[23]];
        Qh[21] = nil;
        Qh[3] = {
            [Qh[4]] = Qh[5],
            [Qh[6]] = Qh[7],
            [Qh[8]] = Qh[9],
            [Qh[10]] = Qh[11],
            [Qh[12]] = Qh[13],
            [Qh[14]] = Qh[15],
            [Qh[16]] = Qh[17],
            [Qh[18]] = Qh[19],
            [Qh[20]] = Qh[21]
        };
        Qh[18] = "\n\xfe\xdb6\xb6\xea\xc1\xf0";
        Qh[14] = "6`\x89u\x7f\x0c\xc7\x15";
        Qh[5] = r15;
        Qh[22] = "\x1f\x02||\xb7\x0c\xe2+\xa9";
        Qh[6] = r16;
        Qh[21] = 33806592638334;
        Qh[9] = 31009479342183;
        Qh[19] = 24969737022827;
        Qh[8] = "R\xe7m\xb1\xf4m\x12\xbd6\xf9\xe22\xc7";
        Qh[11] = 7991845981833;
        Qh[7] = Qh[6](Qh[8], Qh[9]);
        Qh[10] = "\xe7\x12;W\x9f\x1a\x9a=";
        Qh[4] = Qh[5][Qh[7]];
        Qh[7] = r15;
        Qh[20] = "@\x91v\x13";
        Qh[8] = r16;
        Qh[9] = Qh[8](Qh[10], Qh[11]);
        Qh[17] = 26205904121771;
        Qh[15] = 12521326712518;
        Qh[12] = "\xb4\x8d\xf8\n*\xe9\xf6";
        Qh[6] = Qh[7][Qh[9]];
        Qh[9] = r15;
        Qh[10] = r16;
        Qh[23] = 1377821786753;
        Qh[7] = 18747074203;
        Qh[13] = 21734017869704;
        Qh[11] = Qh[10](Qh[12], Qh[13]);
        Qh[8] = Qh[9][Qh[11]];
        Qh[11] = r15;
        Qh[9] = 18747070484;
        Qh[12] = r16;
        Qh[13] = Qh[12](Qh[14], Qh[15]);
        Qh[10] = Qh[11][Qh[13]];
        Qh[11] = 18747069148;
        Qh[24] = "\xa5\xbcT\xdf\xd8t\xf1\x00\x88\xee";
        Qh[16] = "A_\xc4s\x94\xc3?\xca";
        Qh[13] = r15;
        Qh[14] = r16;
        Qh[15] = Qh[14](Qh[16], Qh[17]);
        Qh[12] = Qh[13][Qh[15]];
        Qh[15] = r15;
        Qh[16] = r16;
        Qh[17] = Qh[16](Qh[18], Qh[19]);
        Qh[13] = 18747062535;
        Qh[14] = Qh[15][Qh[17]];
        Qh[25] = 14518155369064;
        Qh[15] = 18747071682;
        Qh[17] = r15;
        Qh[18] = r16;
        Qh[19] = Qh[18](Qh[20], Qh[21]);
        Qh[16] = Qh[17][Qh[19]];
        Qh[19] = r15;
        Qh[17] = 18747073181;
        Qh[20] = r16;
        Qh[21] = Qh[20](Qh[22], Qh[23]);
        Qh[18] = Qh[19][Qh[21]];
        Qh[19] = 18747060903;
        Qh[21] = r15;
        Qh[22] = r16;
        Qh[23] = Qh[22](Qh[24], Qh[25]);
        Qh[20] = Qh[21][Qh[23]];
        Qh[23] = r15;
        Qh[24] = r16;
        Qh[25] = Qh[24](Qh[26], Qh[27]);
        Qh[22] = Qh[23][Qh[25]];
        Qh[21] = 18747067405;
        Qh[23] = 18747063918;
        Qh[27] = 27573582967335;
        Qh[5] = {
            [Qh[6]] = Qh[7],
            [Qh[8]] = Qh[9],
            [Qh[10]] = Qh[11],
            [Qh[12]] = Qh[13],
            [Qh[14]] = Qh[15],
            [Qh[16]] = Qh[17],
            [Qh[18]] = Qh[19],
            [Qh[20]] = Qh[21],
            [Qh[22]] = Qh[23]
        };
        Qh[7] = r15;
        Qh[14] = "\xbe\xb8K\xf3\xc5=\xa3";
        Qh[20] = "\x8c=\xea\xe3\x8b\xe6Q\xb9";
        Qh[10] = "\x7f\xaa\xe4";
        Qh[11] = 32678882638705;
        Qh[8] = r16;
        Qh[9] = Qh[8](Qh[10], Qh[11]);
        Qh[6] = Qh[7][Qh[9]];
        Qh[13] = 3041477182856;
        Qh[9] = r15;
        Qh[23] = 6765047237710;
        Qh[12] = "K\x14e\\\xf3K\xa1/";
        Qh[10] = r16;
        Qh[11] = Qh[10](Qh[12], Qh[13]);
        Qh[56] = 15439419087893;
        Qh[15] = 33962847256007;
        Qh[8] = Qh[9][Qh[11]];
        Qh[9] = 1.1035895829942e+14;
        Qh[16] = "\xf2\xa1M\x15BJ\x11-";
        Qh[17] = 3708297938622;
        Qh[11] = r15;
        Qh[12] = r16;
        Qh[24] = "'\xe5ws\xac\x0b\xect\xcc";
        Qh[13] = Qh[12](Qh[14], Qh[15]);
        Qh[19] = 6063296334599;
        Qh[22] = "\xad=&\xae";
        Qh[10] = Qh[11][Qh[13]];
        Qh[13] = r15;
        Qh[14] = r16;
        Qh[11] = 1.1733353304808e+14;
        Qh[15] = Qh[14](Qh[16], Qh[17]);
        Qh[21] = 23295675820639;
        Qh[12] = Qh[13][Qh[15]];
        Qh[13] = 1.1984611215135e+14;
        Qh[15] = r15;
        Qh[18] = "\xe4\x89\x01\xae\xf8\x0c\x12 ";
        Qh[16] = r16;
        Qh[17] = Qh[16](Qh[18], Qh[19]);
        Qh[14] = Qh[15][Qh[17]];
        Qh[17] = r15;
        Qh[15] = 1.2977324132103e+14;
        Qh[18] = r16;
        Qh[19] = Qh[18](Qh[20], Qh[21]);
        Qh[16] = Qh[17][Qh[19]];
        Qh[25] = 6047622580992;
        Qh[19] = r15;
        Qh[17] = 79090109939093;
        Qh[20] = r16;
        Qh[26] = "F\xb8\xd0n\xfc\xc8mfp\x82";
        Qh[21] = Qh[20](Qh[22], Qh[23]);
        Qh[18] = Qh[19][Qh[21]];
        Qh[21] = r15;
        Qh[22] = r16;
        Qh[19] = 1.3269739418992e+14;
        Qh[23] = Qh[22](Qh[24], Qh[25]);
        Qh[20] = Qh[21][Qh[23]];
        Qh[23] = r15;
        Qh[24] = r16;
        Qh[21] = 134630013742019;
        Qh[25] = Qh[24](Qh[26], Qh[27]);
        Qh[22] = Qh[23][Qh[25]];
        Qh[25] = r15;
        Qh[23] = 92080889861410;
        Qh[26] = r16;
        Qh[27] = Qh[26](Qh[28], Qh[29]);
        Qh[24] = Qh[25][Qh[27]];
        Qh[25] = 74451233229259;
        Qh[7] = {
            [Qh[8]] = Qh[9],
            [Qh[10]] = Qh[11],
            [Qh[12]] = Qh[13],
            [Qh[14]] = Qh[15],
            [Qh[16]] = Qh[17],
            [Qh[18]] = Qh[19],
            [Qh[20]] = Qh[21],
            [Qh[22]] = Qh[23],
            [Qh[24]] = Qh[25]
        };
        Qh[27] = 35018403823538;
        Qh[9] = r15;
        Qh[15] = 1933248529284;
        Qh[20] = "\x17\xd2\xc2^\x10#\xb2\xd2";
        Qh[12] = "J\x9c\xef\xc4\t\xbc\"\xc2\xeb\x8b\xcb\x90\xf6\xc3";
        Qh[10] = r16;
        Qh[13] = 25222664875489;
        Qh[11] = Qh[10](Qh[12], Qh[13]);
        Qh[14] = "\x9d\x87\x92*\xccf\x91I";
        Qh[8] = Qh[9][Qh[11]];
        Qh[23] = 21785968027552;
        Qh[11] = r15;
        Qh[16] = "\xd9\xda\xfb\xa9\xb3\xcd\x9c";
        Qh[19] = 30031507502752;
        Qh[12] = r16;
        Qh[13] = Qh[12](Qh[14], Qh[15]);
        Qh[26] = "\x9d!o\xaa\xc53\xf2\xb1\xf3";
        Qh[10] = Qh[11][Qh[13]];
        Qh[11] = 90478085024465;
        Qh[28] = "\xe6_\x7f\xcb\xb4m\xa8Z\xa8\x91";
        Qh[13] = r15;
        Qh[25] = 3963344160565;
        Qh[17] = 2248196523030;
        Qh[31] = 8030572449435;
        Qh[24] = "K\xd8\xfbk";
        Qh[18] = "q{1\x9c84 .";
        Qh[14] = r16;
        Qh[15] = Qh[14](Qh[16], Qh[17]);
        Qh[12] = Qh[13][Qh[15]];
        Qh[21] = 21064186504784;
        Qh[15] = r15;
        Qh[16] = r16;
        Qh[17] = Qh[16](Qh[18], Qh[19]);
        Qh[22] = "\x97njO\xfbp$\xbf";
        Qh[29] = 16318606990766;
        Qh[13] = 1.3482445061986e+14;
        Qh[14] = Qh[15][Qh[17]];
        Qh[15] = 1.214545054772e+14;
        Qh[17] = r15;
        Qh[18] = r16;
        Qh[19] = Qh[18](Qh[20], Qh[21]);
        Qh[16] = Qh[17][Qh[19]];
        Qh[17] = 94788218468396;
        Qh[19] = r15;
        Qh[20] = r16;
        Qh[21] = Qh[20](Qh[22], Qh[23]);
        Qh[18] = Qh[19][Qh[21]];
        Qh[19] = 1.2912626846485e+14;
        Qh[21] = r15;
        Qh[22] = r16;
        Qh[23] = Qh[22](Qh[24], Qh[25]);
        Qh[20] = Qh[21][Qh[23]];
        Qh[21] = 105962919001086;
        Qh[23] = r15;
        Qh[24] = r16;
        Qh[25] = Qh[24](Qh[26], Qh[27]);
        Qh[22] = Qh[23][Qh[25]];
        Qh[23] = 1.2114588395023e+14;
        Qh[25] = r15;
        Qh[26] = r16;
        Qh[27] = Qh[26](Qh[28], Qh[29]);
        Qh[24] = Qh[25][Qh[27]];
        Qh[27] = r15;
        Qh[28] = r16;
        Qh[25] = 98281136301627;
        Qh[29] = Qh[28](Qh[30], Qh[31]);
        Qh[26] = Qh[27][Qh[29]];
        Qh[27] = nil;
        Qh[9] = {
            [Qh[10]] = Qh[11],
            [Qh[12]] = Qh[13],
            [Qh[14]] = Qh[15],
            [Qh[16]] = Qh[17],
            [Qh[18]] = Qh[19],
            [Qh[20]] = Qh[21],
            [Qh[22]] = Qh[23],
            [Qh[24]] = Qh[25],
            [Qh[26]] = Qh[27]
        };
        Qh[14] = "\x87\xfd\xa5\x04\xeb0\x80";
        Qh[26] = "\xc9\xef\xe3\xff";
        Qh[17] = 12143714244118;
        Qh[30] = "\xf7\x82l\xce\x89h\xb3L\xcf\xb0";
        Qh[28] = "\x1e\xa9\x0cZ\xdb\xe2?',";
        Qh[11] = r15;
        Qh[15] = 16569216687651;
        Qh[29] = 23287261489755;
        Qh[12] = r16;
        Qh[22] = "\x8d\x9a \xcae\xbd\xbe\xb3";
        Qh[13] = Qh[12](Qh[14], Qh[15]);
        Qh[10] = Qh[11][Qh[13]];
        Qh[13] = r15;
        Qh[16] = "\x93\x01)\xa9\xee\xc5\xf0o";
        Qh[14] = r16;
        Qh[18] = "C{\xd0\x11\xc2\"\x9f";
        Qh[15] = Qh[14](Qh[16], Qh[17]);
        Qh[31] = 8421772250961;
        Qh[12] = Qh[13][Qh[15]];
        Qh[15] = r15;
        Qh[16] = r16;
        Qh[19] = 16022418447653;
        Qh[24] = "\xeai\x18\xd0g$>\x95";
        Qh[13] = 10921326949;
        Qh[17] = Qh[16](Qh[18], Qh[19]);
        Qh[20] = "\xb1\x9d\xf5^7\x15\xed\x01";
        Qh[36] = "\x19m\xcd\xce";
        Qh[14] = Qh[15][Qh[17]];
        Qh[15] = 10921320299;
        Qh[17] = r15;
        Qh[18] = r16;
        Qh[21] = 3118862452140;
        Qh[19] = Qh[18](Qh[20], Qh[21]);
        Qh[25] = 7043950464208;
        Qh[16] = Qh[17][Qh[19]];
        Qh[17] = 10921322186;
        Qh[19] = r15;
        Qh[23] = 24665040956637;
        Qh[27] = 28088599474967;
        Qh[20] = r16;
        Qh[21] = Qh[20](Qh[22], Qh[23]);
        Qh[18] = Qh[19][Qh[21]];
        Qh[19] = 10921321317;
        Qh[21] = r15;
        Qh[22] = r16;
        Qh[23] = Qh[22](Qh[24], Qh[25]);
        Qh[20] = Qh[21][Qh[23]];
        Qh[21] = 10921325443;
        Qh[23] = r15;
        Qh[24] = r16;
        Qh[25] = Qh[24](Qh[26], Qh[27]);
        Qh[22] = Qh[23][Qh[25]];
        Qh[23] = 10921324408;
        Qh[25] = r15;
        Qh[26] = r16;
        Qh[27] = Qh[26](Qh[28], Qh[29]);
        Qh[24] = Qh[25][Qh[27]];
        Qh[25] = 10921314188;
        Qh[27] = r15;
        Qh[28] = r16;
        Qh[29] = Qh[28](Qh[30], Qh[31]);
        Qh[26] = Qh[27][Qh[29]];
        Qh[29] = r15;
        Qh[30] = r16;
        Qh[31] = Qh[30](Qh[32], Qh[33]);
        Qh[27] = 10921315373;
        Qh[28] = Qh[29][Qh[31]];
        Qh[29] = nil;
        Qh[11] = {
            [Qh[12]] = Qh[13],
            [Qh[14]] = Qh[15],
            [Qh[16]] = Qh[17],
            [Qh[18]] = Qh[19],
            [Qh[20]] = Qh[21],
            [Qh[22]] = Qh[23],
            [Qh[24]] = Qh[25],
            [Qh[26]] = Qh[27],
            [Qh[28]] = Qh[29]
        };
        Qh[13] = r15;
        Qh[23] = 7989690912392;
        Qh[33] = 22574778853648;
        Qh[18] = "\x81\xb9\xe8";
        Qh[17] = 9211215761601;
        Qh[28] = "\x02a\xc5\xf0\x8d\x1d\x1d\xa4";
        Qh[14] = r16;
        Qh[16] = "\xb9\xc0\xff\x11\x00";
        Qh[19] = 5916282800834;
        Qh[15] = Qh[14](Qh[16], Qh[17]);
        Qh[24] = "V\xb87\x94";
        Qh[12] = Qh[13][Qh[15]];
        Qh[15] = r15;
        Qh[22] = "$R\xf1\xfa";
        Qh[16] = r16;
        Qh[17] = Qh[16](Qh[18], Qh[19]);
        Qh[14] = Qh[15][Qh[17]];
        Qh[32] = "\xdcS\xc8\x05";
        Qh[17] = r15;
        Qh[20] = "\xa7:1\x87";
        Qh[21] = 10463859921672;
        Qh[18] = r16;
        Qh[25] = 9624580739457;
        Qh[19] = Qh[18](Qh[20], Qh[21]);
        Qh[15] = 656118852;
        Qh[16] = Qh[17][Qh[19]];
        Qh[31] = 16389627977168;
        Qh[17] = 656121766;
        Qh[19] = r15;
        Qh[20] = r16;
        Qh[21] = Qh[20](Qh[22], Qh[23]);
        Qh[18] = Qh[19][Qh[21]];
        Qh[21] = r15;
        Qh[22] = r16;
        Qh[23] = Qh[22](Qh[24], Qh[25]);
        Qh[26] = "fC\xd1\xe6";
        Qh[27] = 16527156272656;
        Qh[19] = 656117878;
        Qh[20] = Qh[21][Qh[23]];
        Qh[21] = 656115606;
        Qh[23] = r15;
        Qh[24] = r16;
        Qh[25] = Qh[24](Qh[26], Qh[27]);
        Qh[22] = Qh[23][Qh[25]];
        Qh[23] = 656119721;
        Qh[29] = 31285366733032;
        Qh[25] = r15;
        Qh[26] = r16;
        Qh[27] = Qh[26](Qh[28], Qh[29]);
        Qh[30] = "\xa1b\x90z\xc2";
        Qh[24] = Qh[25][Qh[27]];
        Qh[25] = 656121397;
        Qh[27] = r15;
        Qh[28] = r16;
        Qh[29] = Qh[28](Qh[30], Qh[31]);
        Qh[26] = Qh[27][Qh[29]];
        Qh[27] = 656114359;
        Qh[29] = r15;
        Qh[30] = r16;
        Qh[31] = Qh[30](Qh[32], Qh[33]);
        Qh[28] = Qh[29][Qh[31]];
        Qh[32] = 886742569;
        Qh[30] = 656117400;
        Qh[31] = 656118341;
        Qh[29] = {
            Qh[30],
            Qh[31],
            Qh[32]
        };
        Qh[38] = "\x16vx\x01";
        Qh[13] = {
            [Qh[14]] = Qh[15],
            [Qh[16]] = Qh[17],
            [Qh[18]] = Qh[19],
            [Qh[20]] = Qh[21],
            [Qh[22]] = Qh[23],
            [Qh[24]] = Qh[25],
            [Qh[26]] = Qh[27],
            [Qh[28]] = Qh[29]
        };
        Qh[15] = r15;
        Qh[20] = "\x03\x001";
        Qh[21] = 30462407440233;
        Qh[19] = 23674577595152;
        Qh[18] = "J:\xe05\xb5";
        Qh[16] = r16;
        Qh[17] = Qh[16](Qh[18], Qh[19]);
        Qh[14] = Qh[15][Qh[17]];
        Qh[17] = r15;
        Qh[18] = r16;
        Qh[19] = Qh[18](Qh[20], Qh[21]);
        Qh[23] = 12613071623921;
        Qh[24] = "\xd4\\\xf3\x0c";
        Qh[28] = "\xb69\xed\xe0";
        Qh[16] = Qh[17][Qh[19]];
        Qh[19] = r15;
        Qh[20] = r16;
        Qh[17] = 616091570;
        Qh[22] = "Ir0e";
        Qh[21] = Qh[20](Qh[22], Qh[23]);
        Qh[29] = 7460207021457;
        Qh[27] = 32710603979648;
        Qh[18] = Qh[19][Qh[21]];
        Qh[19] = 616095330;
        Qh[21] = r15;
        Qh[41] = 5308279359911;
        Qh[32] = "\x96\xe0\xba\x02\xe4";
        Qh[22] = r16;
        Qh[25] = 25607826140820;
        Qh[31] = 11487640540389;
        Qh[26] = "\xc4\xd1\xf2x";
        Qh[23] = Qh[22](Qh[24], Qh[25]);
        Qh[20] = Qh[21][Qh[23]];
        Qh[21] = 616090535;
        Qh[23] = r15;
        Qh[24] = r16;
        Qh[25] = Qh[24](Qh[26], Qh[27]);
        Qh[22] = Qh[23][Qh[25]];
        Qh[25] = r15;
        Qh[23] = 616087089;
        Qh[30] = "`pZ\xb8 \xaa\xeaw";
        Qh[26] = r16;
        Qh[27] = Qh[26](Qh[28], Qh[29]);
        Qh[24] = Qh[25][Qh[27]];
        Qh[33] = 19312199901984;
        Qh[27] = r15;
        Qh[25] = 616092998;
        Qh[28] = r16;
        Qh[29] = Qh[28](Qh[30], Qh[31]);
        Qh[26] = Qh[27][Qh[29]];
        Qh[27] = 616094091;
        Qh[29] = r15;
        Qh[30] = r16;
        Qh[31] = Qh[30](Qh[32], Qh[33]);
        Qh[28] = Qh[29][Qh[31]];
        Qh[31] = r15;
        Qh[32] = r16;
        Qh[29] = 616086039;
        Qh[33] = Qh[32](Qh[34], Qh[35]);
        Qh[34] = 885531463;
        Qh[30] = Qh[31][Qh[33]];
        Qh[32] = 616088211;
        Qh[33] = 616089559;
        Qh[31] = {
            Qh[32],
            Qh[33],
            Qh[34]
        };
        Qh[15] = {
            [Qh[16]] = Qh[17],
            [Qh[18]] = Qh[19],
            [Qh[20]] = Qh[21],
            [Qh[22]] = Qh[23],
            [Qh[24]] = Qh[25],
            [Qh[26]] = Qh[27],
            [Qh[28]] = Qh[29],
            [Qh[30]] = Qh[31]
        };
        Qh[20] = "\x16/\t\x05<@\xe5\xc3\xac ";
        Qh[17] = r15;
        Qh[18] = r16;
        Qh[25] = 19454123647843;
        Qh[32] = "\xa6g\xa9\xb3\xd7\x91\x0fv";
        Qh[21] = 11321672258712;
        Qh[47] = 35112380841950;
        Qh[31] = 292169990280;
        Qh[19] = Qh[18](Qh[20], Qh[21]);
        Qh[30] = "ev\xd9A";
        Qh[16] = Qh[17][Qh[19]];
        Qh[19] = r15;
        Qh[22] = "(\x07\x0c";
        Qh[23] = 446434787535;
        Qh[20] = r16;
        Qh[24] = "\xfe\xca\xc8\x0f";
        Qh[21] = Qh[20](Qh[22], Qh[23]);
        Qh[26] = ";\xca7\x94";
        Qh[18] = Qh[19][Qh[21]];
        Qh[21] = r15;
        Qh[19] = 616010382;
        Qh[35] = 2070817883076;
        Qh[33] = 31009751414888;
        Qh[22] = r16;
        Qh[27] = 27890888946363;
        Qh[23] = Qh[22](Qh[24], Qh[25]);
        Qh[20] = Qh[21][Qh[23]];
        Qh[28] = "~\xa6\x95\x13";
        Qh[21] = 616013216;
        Qh[23] = r15;
        Qh[24] = r16;
        Qh[25] = Qh[24](Qh[26], Qh[27]);
        Qh[22] = Qh[23][Qh[25]];
        Qh[25] = r15;
        Qh[29] = 12590149031654;
        Qh[26] = r16;
        Qh[27] = Qh[26](Qh[28], Qh[29]);
        Qh[24] = Qh[25][Qh[27]];
        Qh[34] = " \xf4\xe8\xba\x1a";
        Qh[25] = 616005863;
        Qh[23] = 616008936;
        Qh[27] = r15;
        Qh[28] = r16;
        Qh[29] = Qh[28](Qh[30], Qh[31]);
        Qh[26] = Qh[27][Qh[29]];
        Qh[29] = r15;
        Qh[27] = 616011509;
        Qh[30] = r16;
        Qh[31] = Qh[30](Qh[32], Qh[33]);
        Qh[28] = Qh[29][Qh[31]];
        Qh[29] = 616012453;
        Qh[31] = r15;
        Qh[32] = r16;
        Qh[33] = Qh[32](Qh[34], Qh[35]);
        Qh[30] = Qh[31][Qh[33]];
        Qh[33] = r15;
        Qh[34] = r16;
        Qh[35] = Qh[34](Qh[36], Qh[37]);
        Qh[31] = 616003713;
        Qh[34] = 616006778;
        Qh[32] = Qh[33][Qh[35]];
        Qh[37] = 7374613957994;
        Qh[36] = 886862142;
        Qh[35] = 616008087;
        Qh[33] = {
            Qh[34],
            Qh[35],
            Qh[36]
        };
        Qh[17] = {
            [Qh[18]] = Qh[19],
            [Qh[20]] = Qh[21],
            [Qh[22]] = Qh[23],
            [Qh[24]] = Qh[25],
            [Qh[26]] = Qh[27],
            [Qh[28]] = Qh[29],
            [Qh[30]] = Qh[31],
            [Qh[32]] = Qh[33]
        };
        Qh[19] = r15;
        Qh[33] = 21674175522668;
        Qh[20] = r16;
        Qh[25] = 25358079372832;
        Qh[35] = 6615849356296;
        Qh[36] = "b/\xe5\xd5(";
        Qh[30] = "\xd3\xc2!'";
        Qh[23] = 23913978784639;
        Qh[22] = "\xbcX\x80\xe3\x80zx";
        Qh[29] = 31336361539840;
        Qh[21] = Qh[20](Qh[22], Qh[23]);
        Qh[27] = 15757892721833;
        Qh[34] = "\xb1*\xbb\xf7\x8b_73";
        Qh[18] = Qh[19][Qh[21]];
        Qh[32] = "\xf9\rR\xa5";
        Qh[21] = r15;
        Qh[24] = "\x9b0\x87";
        Qh[28] = "\x1b}6w";
        Qh[22] = r16;
        Qh[26] = "_\x19\xddb";
        Qh[23] = Qh[22](Qh[24], Qh[25]);
        Qh[20] = Qh[21][Qh[23]];
        Qh[21] = 616140816;
        Qh[23] = r15;
        Qh[24] = r16;
        Qh[25] = Qh[24](Qh[26], Qh[27]);
        Qh[22] = Qh[23][Qh[25]];
        Qh[23] = 616146177;
        Qh[25] = r15;
        Qh[26] = r16;
        Qh[27] = Qh[26](Qh[28], Qh[29]);
        Qh[24] = Qh[25][Qh[27]];
        Qh[27] = r15;
        Qh[31] = 34569295134433;
        Qh[25] = 616139451;
        Qh[28] = r16;
        Qh[29] = Qh[28](Qh[30], Qh[31]);
        Qh[26] = Qh[27][Qh[29]];
        Qh[29] = r15;
        Qh[27] = 616134815;
        Qh[30] = r16;
        Qh[31] = Qh[30](Qh[32], Qh[33]);
        Qh[28] = Qh[29][Qh[31]];
        Qh[31] = r15;
        Qh[29] = 616143378;
        Qh[32] = r16;
        Qh[33] = Qh[32](Qh[34], Qh[35]);
        Qh[30] = Qh[31][Qh[33]];
        Qh[33] = r15;
        Qh[31] = 616144772;
        Qh[34] = r16;
        Qh[35] = Qh[34](Qh[36], Qh[37]);
        Qh[32] = Qh[33][Qh[35]];
        Qh[33] = 616133594;
        Qh[35] = r15;
        Qh[36] = r16;
        Qh[37] = Qh[36](Qh[38], Qh[39]);
        Qh[36] = 616136790;
        Qh[34] = Qh[35][Qh[37]];
        Qh[37] = 616138447;
        Qh[38] = 886888594;
        Qh[35] = {
            Qh[36],
            Qh[37],
            Qh[38]
        };
        Qh[19] = {
            [Qh[20]] = Qh[21],
            [Qh[22]] = Qh[23],
            [Qh[24]] = Qh[25],
            [Qh[26]] = Qh[27],
            [Qh[28]] = Qh[29],
            [Qh[30]] = Qh[31],
            [Qh[32]] = Qh[33],
            [Qh[34]] = Qh[35]
        };
        Qh[24] = "\xf9\x04\x9e\xb7\xe5\xdb";
        Qh[34] = "\x98\x84K\x06";
        Qh[30] = "\xd1\x008\"";
        Qh[31] = 10533412393769;
        Qh[21] = r15;
        Qh[25] = 23143005628952;
        Qh[32] = "\x95(\xff?";
        Qh[33] = 27150186197346;
        Qh[22] = r16;
        Qh[23] = Qh[22](Qh[24], Qh[25]);
        Qh[20] = Qh[21][Qh[23]];
        Qh[23] = r15;
        Qh[28] = "Y\xd484";
        Qh[26] = "\xdf\xd9\xb7";
        Qh[27] = 3475608585810;
        Qh[24] = r16;
        Qh[25] = Qh[24](Qh[26], Qh[27]);
        Qh[22] = Qh[23][Qh[25]];
        Qh[23] = 910025107;
        Qh[35] = 7782047485479;
        Qh[25] = r15;
        Qh[29] = 12504012150462;
        Qh[26] = r16;
        Qh[27] = Qh[26](Qh[28], Qh[29]);
        Qh[24] = Qh[25][Qh[27]];
        Qh[25] = 910034870;
        Qh[27] = r15;
        Qh[28] = r16;
        Qh[29] = Qh[28](Qh[30], Qh[31]);
        Qh[36] = "\x87N\x05h5e<J";
        Qh[26] = Qh[27][Qh[29]];
        Qh[27] = 910016857;
        Qh[29] = r15;
        Qh[30] = r16;
        Qh[31] = Qh[30](Qh[32], Qh[33]);
        Qh[28] = Qh[29][Qh[31]];
        Qh[29] = 910001910;
        Qh[37] = 23146484017690;
        Qh[31] = r15;
        Qh[32] = r16;
        Qh[33] = Qh[32](Qh[34], Qh[35]);
        Qh[30] = Qh[31][Qh[33]];
        Qh[31] = 910028158;
        Qh[33] = r15;
        Qh[34] = r16;
        Qh[35] = Qh[34](Qh[36], Qh[37]);
        Qh[39] = 17573640232951;
        Qh[32] = Qh[33][Qh[35]];
        Qh[35] = r15;
        Qh[38] = "Y\xf0\xf9Jd";
        Qh[36] = r16;
        Qh[33] = 910030921;
        Qh[37] = Qh[36](Qh[38], Qh[39]);
        Qh[34] = Qh[35][Qh[37]];
        Qh[35] = 909997997;
        Qh[37] = r15;
        Qh[38] = r16;
        Qh[39] = Qh[38](Qh[40], Qh[41]);
        Qh[38] = 910004836;
        Qh[36] = Qh[37][Qh[39]];
        Qh[39] = 910009958;
        Qh[40] = 1018536639;
        Qh[37] = {
            Qh[38],
            Qh[39],
            Qh[40]
        };
        Qh[21] = {
            [Qh[22]] = Qh[23],
            [Qh[24]] = Qh[25],
            [Qh[26]] = Qh[27],
            [Qh[28]] = Qh[29],
            [Qh[30]] = Qh[31],
            [Qh[32]] = Qh[33],
            [Qh[34]] = Qh[35],
            [Qh[36]] = Qh[37]
        };
        Qh[23] = r15;
        Qh[26] = "m\xe1\xfd\x98\xd7Z\x88";
        Qh[30] = "\xfe\xa05`";
        Qh[27] = 30606691055532;
        Qh[34] = "\xa9P\x9f2";
        Qh[41] = 33089469873200;
        Qh[24] = r16;
        Qh[29] = 29061280773340;
        Qh[40] = "\xbe\x86 7\x89";
        Qh[25] = Qh[24](Qh[26], Qh[27]);
        Qh[31] = 24620479261896;
        Qh[28] = "\x11\x17\xa7";
        Qh[22] = Qh[23][Qh[25]];
        Qh[36] = "\x002\xbeF";
        Qh[39] = 26299993796566;
        Qh[25] = r15;
        Qh[26] = r16;
        Qh[27] = Qh[26](Qh[28], Qh[29]);
        Qh[33] = 6845870148723;
        Qh[38] = "I\xc0\x84e\xad\x90\xbdz";
        Qh[24] = Qh[25][Qh[27]];
        Qh[25] = 742638842;
        Qh[27] = r15;
        Qh[28] = r16;
        Qh[32] = "g(<K";
        Qh[29] = Qh[28](Qh[30], Qh[31]);
        Qh[26] = Qh[27][Qh[29]];
        Qh[27] = 742640026;
        Qh[35] = 5198580926836;
        Qh[37] = 25066914065816;
        Qh[29] = r15;
        Qh[30] = r16;
        Qh[31] = Qh[30](Qh[32], Qh[33]);
        Qh[28] = Qh[29][Qh[31]];
        Qh[29] = 742637942;
        Qh[31] = r15;
        Qh[32] = r16;
        Qh[33] = Qh[32](Qh[34], Qh[35]);
        Qh[30] = Qh[31][Qh[33]];
        Qh[33] = r15;
        Qh[34] = r16;
        Qh[35] = Qh[34](Qh[36], Qh[37]);
        Qh[31] = 742637151;
        Qh[32] = Qh[33][Qh[35]];
        Qh[33] = 742639220;
        Qh[35] = r15;
        Qh[36] = r16;
        Qh[37] = Qh[36](Qh[38], Qh[39]);
        Qh[34] = Qh[35][Qh[37]];
        Qh[37] = r15;
        Qh[35] = 742639812;
        Qh[38] = r16;
        Qh[39] = Qh[38](Qh[40], Qh[41]);
        Qh[36] = Qh[37][Qh[39]];
        Qh[39] = r15;
        Qh[40] = r16;
        Qh[41] = Qh[40](Qh[42], Qh[43]);
        Qh[37] = 742636889;
        Qh[42] = 885477856;
        Qh[38] = Qh[39][Qh[41]];
        Qh[40] = 742637544;
        Qh[41] = 742638445;
        Qh[39] = {
            Qh[40],
            Qh[41],
            Qh[42]
        };
        Qh[23] = {
            [Qh[24]] = Qh[25],
            [Qh[26]] = Qh[27],
            [Qh[28]] = Qh[29],
            [Qh[30]] = Qh[31],
            [Qh[32]] = Qh[33],
            [Qh[34]] = Qh[35],
            [Qh[36]] = Qh[37],
            [Qh[38]] = Qh[39]
        };
        Qh[24] = 11415667594435;
        r101 = {
            ["Adidas Sports"] = {
                ["WalkAnim"] = 18537392113,
                ["RunAnim"] = 18537384940,
                ["JumpAnim"] = 18537380791,
                ["FallAnim"] = 18537367238,
                ["SwimIdle"] = 18537387180,
                ["Swim"] = 18537389531,
                ["Animation1"] = 18537376492,
                ["Animation2"] = 18537371272,
                [r15[r16("<ZUQz\xbd\x90>\x14", Qh[1])]] = 18537363391
            },
            ["Adidas Community"] = {
                ["WalkAnim"] = 1.2215085545701e+14,
                ["RunAnim"] = 82598234841035,
                ["JumpAnim"] = 75290611992385,
                ["FallAnim"] = 98600215928904,
                ["SwimIdle"] = 1.0934652032416e+14,
                ["Swim"] = 1.3330848326621e+14,
                ["Animation1"] = 1.2225745849846e+14,
                [r15[r16("\xae\xed\x90\x14\rd~Kz\xb2", Qh[1])]] = 1.0235715100577e+14,
                [r15[Qh[1]]] = 88763136693023
            },
            ["Adidas Aura"] = {
                ["WalkAnim"] = 83842218823011,
                ["RunAnim"] = 1.1832032271887e+14,
                ["JumpAnim"] = 109996626521204,
                ["FallAnim"] = 95603166884636,
                ["SwimIdle"] = 94922130551805,
                ["Swim"] = 1.345301283839e+14,
                [r15[r16("9n\xe8\r\x96\xacJe\x08s", Qh[1])]] = 1.1021118684035e+14,
                [r15[Qh[1]]] = 1.1419113726506e+14,
                [Qh[1][Qh[3]]] = Qh[1]
            },
            ["Wicked Popular"] = {
                ["WalkAnim"] = 92072849924640,
                ["RunAnim"] = 72301599441680,
                ["JumpAnim"] = 1.043252452852e+14,
                ["FallAnim"] = 1.2115244276248e+14,
                ["Animation1"] = 1.1883222298205e+14,
                [r15[r16("\x9c;\xe36|7\x980\x0b", Qh[1])]] = 1.3132683050978e+14,
                [r15[Qh[1]]] = 1.131994151182e+14,
                [Qh[1][Qh[3]]] = Qh[1],
                [Qh[2]] = Qh[3]
            },
            ["Elder"] = {
                ["WalkAnim"] = 10921111375,
                ["RunAnim"] = 10921104374,
                ["JumpAnim"] = 10921107367,
                ["FallAnim"] = 10921105765,
                [r15[r16("\xc4\x91\x8a\xd5)s\r)", Qh[1])]] = 10921110146,
                [r15[Qh[1]]] = 10921108971,
                [Qh[1][Qh[3]]] = Qh[1],
                [Qh[2]] = Qh[3],
                [Qh[4]] = Qh[5]
            },
            ["Zombie"] = {
                ["WalkAnim"] = 10921355261,
                ["RunAnim"] = 616163682,
                ["JumpAnim"] = 10921351278,
                [r15[r16("\x1b\xe8l\x86\x1a\"\x16\x16", Qh[1])]] = 10921350320,
                [r15[Qh[1]]] = 10921353442,
                [Qh[1][Qh[3]]] = Qh[1],
                [Qh[2]] = Qh[3],
                [Qh[4]] = Qh[5],
                [Qh[6]] = Qh[7]
            },
            ["Mage"] = {
                ["WalkAnim"] = 10921152678,
                ["RunAnim"] = 10921148209,
                [r15[r16("\x9eLM.\xc7\x91\x82\xa9", Qh[1])]] = 10921149743,
                [r15[Qh[1]]] = 10921148939,
                [Qh[1][Qh[3]]] = Qh[1],
                [Qh[2]] = Qh[3],
                [Qh[4]] = Qh[5],
                [Qh[6]] = Qh[7],
                [Qh[8]] = Qh[9]
            },
            ["Catwalk Glam"] = {
                ["WalkAnim"] = 1.0916872448275e+14,
                [r15[r16("\xd3\xcfc\xc3\xb6\x8e\n", Qh[1])]] = 81024476153754,
                [r15[Qh[1]]] = 1.1693632651698e+14,
                [Qh[1][Qh[3]]] = Qh[1],
                [Qh[2]] = Qh[3],
                [Qh[4]] = Qh[5],
                [Qh[6]] = Qh[7],
                [Qh[8]] = Qh[9],
                [Qh[10]] = Qh[11]
            },
            ["Astronaut"] = {
                [r15[r16("\xa8\xf7\x0b~i\xaa\x01\xb9", Qh[1])]] = 10921046031,
                [r15[Qh[1]]] = 10921039308,
                [Qh[1][Qh[3]]] = Qh[1],
                [Qh[2]] = Qh[3],
                [Qh[4]] = Qh[5],
                [Qh[6]] = Qh[7],
                [Qh[8]] = Qh[9],
                [Qh[10]] = Qh[11],
                [Qh[12]] = Qh[13]
            },
            [r15[r16("m\xe0\x886/\x95\xd4&\x9d\xb3+aH\xf9\xa4\x03*E6{\xd5\xf36B\x9b\xd8wE\xf7", Qh[1])]] = {
                [r15[Qh[1]]] = 73718308412641,
                [Qh[1][Qh[3]]] = Qh[1],
                [Qh[2]] = Qh[3],
                [Qh[4]] = Qh[5],
                [Qh[6]] = Qh[7],
                [Qh[8]] = Qh[9],
                [Qh[10]] = Qh[11],
                [Qh[12]] = Qh[13],
                [Qh[14]] = Qh[15]
            },
            [r15[Qh[1]]] = {
                [Qh[1][Qh[3]]] = Qh[1],
                [Qh[2]] = Qh[3],
                [Qh[4]] = Qh[5],
                [Qh[6]] = Qh[7],
                [Qh[8]] = Qh[9],
                [Qh[10]] = Qh[11],
                [Qh[12]] = Qh[13],
                [Qh[14]] = Qh[15],
                [Qh[16]] = Qh[17]
            },
            [Qh[1][Qh[3]]] = Qh[1],
            [Qh[2]] = Qh[3],
            [Qh[4]] = Qh[5],
            [Qh[6]] = Qh[7],
            [Qh[8]] = Qh[9],
            [Qh[10]] = Qh[11],
            [Qh[12]] = Qh[13],
            [Qh[14]] = Qh[15],
            [Qh[16]] = Qh[17],
            [Qh[18]] = Qh[19],
            [Qh[20]] = Qh[21],
            [Qh[22]] = Qh[23]
        };
        Qh[7] = function(arg1_27, ...)
            if arg1_27 then
                if r43.PostEffects.vignette then
                    return;
                end;
                j = Instance.new("ScreenGui");
                j.Name = "VignetteEffect";
                j.ResetOnSpawn = false;
                j.IgnoreGuiInset = true;
                H = Instance.new("Frame");
                H.Size = UDim2.new(1, 0, 1, 0);
                H.BackgroundColor3 = Color3.fromRGB(0, 0, 0);
                H.BackgroundTransparency = 0.5;
                H.BorderSizePixel = 0;
                H.Parent = j;
                v3 = r34;
                j.Parent = v3.WaitForChild(v3, "PlayerGui");
                r43.PostEffects.vignette = j;
            else
                if r43.PostEffects.vignette then
                    pcall(function(...)
                        v5 = r43.PostEffects.vignette;
                        v5.Destroy(v5);
                        return; 
                    end);
                    r43.PostEffects.vignette = nil;
                end;
                return;
            end; 
        end;
        local function r102(arg1_28, ...)
            v1 = arg1_28;
            j = r101[v1];
            if not j then
                return false;
            end;
            H = r34.Character;
            if not H then
                return false;
            end;
            e = H.FindFirstChild(H, "Animate");
            if not e then
                return false;
            end;
            local function Q(arg1_29, arg2_29, ...)
                v1 = arg1_29;
                j = arg2_29;
                if v1 then
                    v3 = arg2_29;
                end;
                if v1 then
                    v1.AnimationId = "rbxassetid://" .. tostring(j);
                end;
                return; 
            end;
            local function v4(arg1_30, arg2_30, ...)
                j = arg2_30;
                v1 = arg1_30;
                if not v1 then
                    return nil;
                end;
                H = v1.FindFirstChild(v1, j);
                if not H then
                    H = Instance.new("Animation");
                    e = j;
                    H.Name = e;
                    e = arg1_30;
                    H.Parent = e;
                end;
                return H; 
            end;
            v5 = e.FindFirstChild(e, "idle");
            v9 = true;
            N = Q(v4(e.FindFirstChild(e, "walk"), "WalkAnim"), j.WalkAnim or j.Walk);
            v5 = N;
            v5 = Q(v4(e.FindFirstChild(e, "walk"), "WalkAnim"), j.WalkAnim or j.Walk);
            v5 = Q(v4(e.FindFirstChild(e, "run"), "RunAnim"), j.RunAnim or j.Run);
            v5 = Q(v4(e.FindFirstChild(e, "jump"), "JumpAnim"), j.JumpAnim or j.Jump);
            v5 = Q(v4(e.FindFirstChild(e, "fall"), "FallAnim"), j.FallAnim or j.Fall);
            Q(v4(e.FindFirstChild(e, "climb"), "ClimbAnim"), j.ClimbAnim or j.Climb);
            v5 = Q(v4(e.FindFirstChild(e, "swim"), "Swim"), j.Swim);
            Q(v4(e.FindFirstChild(e, "swimidle"), "SwimIdle"), j.SwimIdle or j.Swim);
            if v9 then
                N = v9.FindFirstChild(v9, "Animation1");
                J = v9.FindFirstChild(v9, "Animation2");
                if j.Animation1 then
                    (function(arg1_31, arg2_31, ...)
                        v1 = arg1_31;
                        j = arg2_31;
                        if v1 then
                            v3 = arg2_31;
                        end;
                        if v1 then
                            v1.AnimationId = "rbxassetid://" .. tostring(j);
                        end;
                        return; 
                    end)(N, r101[v1].Animation1);
                end;
                if j.Animation2 then
                    (function(arg1_32, arg2_32, ...)
                        v1 = arg1_32;
                        j = arg2_32;
                        if v1 then
                            v3 = arg2_32;
                        end;
                        if v1 then
                            v1.AnimationId = "rbxassetid://" .. tostring(j);
                        end;
                        return; 
                    end)(J, r101[v1].Animation2);
                end;
                if j.Idle then
                    if N then
                        v3 = r101[v1].Idle[1];
                    end;
                    if N then
                        (function(arg1_33, arg2_33, ...)
                            v1 = arg1_33;
                            j = arg2_33;
                            if v1 then
                                v3 = arg2_33;
                            end;
                            if v1 then
                                v1.AnimationId = "rbxassetid://" .. tostring(j);
                            end;
                            return; 
                        end)(v9.FindFirstChild(v9, "Animation1"), r101[v1].Idle[1]);
                    end;
                    if J then
                        v3 = r101[v1].Idle[2];
                    end;
                    if J then
                        v5 = j[v3];
                        (function(arg1_34, arg2_34, ...)
                            v1 = arg1_34;
                            j = arg2_34;
                            if v1 then
                                v3 = arg2_34;
                            end;
                            if v1 then
                                v1.AnimationId = "rbxassetid://" .. tostring(j);
                            end;
                            return; 
                        end)(v9.FindFirstChild(v9, "Animation2"), j.Idle[2] or j.Idle[1]);
                    end;
                end;
            end;
            e.Disabled = true;
            task.wait(.06);
            e.Disabled = false;
            r103 = H.FindFirstChildOfClass(H, "Humanoid");
            if r103 then
                pcall(function(...)
                    v5 = r103;
                    v5.ChangeState(v5, Enum.HumanoidStateType.Landed);
                    task.wait(.03);
                    v5 = r103;
                    v5.ChangeState(v5, Enum.HumanoidStateType.Running);
                    return; 
                end);
            end;
            r42.AnimPack = v1;
            return true; 
        end;
        Qh[5] = function(arg1_35, ...)
            v5 = r28;
            Q = v5;
            H = v5;
            v5.Brightness = arg1_35 and 1.5 or 1;
            return; 
        end;
        local function r104(arg1_36, ...)
            v1 = arg1_36;
            r42.AnimPackEnabled = v1;
            if v1 then
                if r42.AnimPack ~= "" then
                    r102(r42.AnimPack);
                    r38("\xd0\x90\xd0\xbd\xd0\xb8\xd0\xbc\xd0\xb0\xd1\x86\xd0\xb8\xd0\xb8", "\xd0\x9f\xd1\x80\xd0\xb8\xd0\xbc\xd0\xb5\xd0\xbd\xd1\x91\xd0\xbd: " .. r42.AnimPack, 2);
                else
                    r38("\xd0\x90\xd0\xbd\xd0\xb8\xd0\xbc\xd0\xb0\xd1\x86\xd0\xb8\xd0\xb8", "\xd0\xa1\xd0\xbd\xd0\xb0\xd1\x87\xd0\xb0\xd0\xbb\xd0\xb0 \xd0\xb2\xd1\x8b\xd0\xb1\xd0\xb5\xd1\x80\xd0\xb8 \xd0\xbf\xd0\xb0\xd1\x87\xd0\xba\xd1\x83!", 2);
                end;
            end;
            return; 
        end;
        local function r105(...)
            v5 = workspace;
            v1 = v5.FindFirstChild(v5, "GunDrop");
            if v1 then
                j = r34.Character;
                if j then
                    v3 = j.FindFirstChild(j, "HumanoidRootPart");
                end;
                if j then
                    v3.CFrame = j.HumanoidRootPart.CFrame;
                    r38("Teleport Gun", "\xd0\x9f\xd1\x83\xd1\x88\xd0\xba\xd0\xb0 \xd0\xbf\xd1\x80\xd0\xb8\xd1\x82\xd1\x8f\xd0\xbd\xd1\x83\xd1\x82\xd0\xb0!", 2);
                else
                    r38("Teleport Gun", "\xd0\x9f\xd0\xb5\xd1\x80\xd1\x81\xd0\xbe\xd0\xbd\xd0\xb0\xd0\xb6 \xd0\xbd\xd0\xb5 \xd0\xbd\xd0\xb0\xd0\xb9\xd0\xb4\xd0\xb5\xd0\xbd!", 2);
                end;
            else
                r38("Teleport Gun", "\xd0\x9f\xd1\x83\xd1\x88\xd0\xba\xd0\xb8 \xd0\xbd\xd0\xb5\xd1\x82 \xd0\xbd\xd0\xb0 \xd0\xb7\xd0\xb5\xd0\xbc\xd0\xbb\xd0\xb5!", 2);
            end;
            return; 
        end;
        Qh[1] = function(...)
            H = r15;
            e = r16;
            if not r42.TracersEnabled then
                e = r43;
                H = e.Tracers;
                v1 = e[2];
                H = e[1];
                for j, Q in pairs(H) do
                    e = j;
                    Q.Visible = false; 
                end;
                return;
            end;
            Vector2.new(r35.ViewportSize.v2 / 2, r35.ViewportSize.v3);
            v5 = pairs;
            v4 = r43;
            v2 = "Tracers";
            H = v4[2];
            j = v4[1];
            for e, v4 in v5(v4[v2]) do
                v5 = r24;
                v2 = v5.GetPlayerByUserId(v5, e);
                v7 = not v2 or not v2.Character;
                if v7 then
                    v4.Visible = false;
                else
                    v5 = v2.Character;
                    v9 = r16;
                    v7 = v5.FindFirstChild(v5, "HumanoidRootPart");
                    if not v7 then
                        v4.Visible = false;
                    else
                        v5 = r35;
                        v9 = {
                            v5.WorldToViewportPoint(v5, v7.Position)
                        };
                        y = v5.WorldToViewportPoint(v5, v7.Position);
                        if not v9[2] then
                            v4.Visible = false;
                        else
                            v6 = Vector2.new(r35.ViewportSize.v2 / 2, r35.ViewportSize.v3);
                            v4.From = v6;
                            v4.To = Vector2.new(v6.v2, v6.v3);
                            v4.Visible = true;
                            v4.Color = r50(v5.GetPlayerByUserId(v5, Q));
                        end;
                    end;
                end; 
            end;
            return; 
        end;
        Qh[25] = 6024695728885;
        local function r106(arg1_37, ...)
            v1 = arg1_37;
            r45(r43.TeleportGunConn);
            r43.TeleportGunConn = nil;
            if not v1 or v1 == "" then
                return;
            end;
            r107 = Enum.KeyCode[v1];
            if not r107 then
                return;
            end;
            H = r27.InputBegan;
            r43.TeleportGunConn = H.Connect(H, function(arg1_38, arg2_38, ...)
                if arg2_38 then
                    return;
                end;
                if arg1_38.KeyCode == r107 then
                    r105();
                end;
                return; 
            end);
            return; 
        end;
        local function r108(arg1_39, ...)
            v1 = arg1_39;
            r42.TeleportGunEnabled = v1;
            if v1 then
                r106(r42.TeleportGunKey);
                r38("Teleport Gun", "\xd0\x92\xd0\xba\xd0\xbb\xd1\x8e\xd1\x87\xd0\xb5\xd0\xbd (\xd1\x85\xd0\xbe\xd1\x82\xd0\xba\xd0\xb5\xd0\xb9: " .. r42.TeleportGunKey .. ")", 2);
            else
                r45(r43.TeleportGunConn);
                r43.TeleportGunConn = nil;
                r38("Teleport Gun", "\xd0\x92\xd1\x8b\xd0\xba\xd0\xbb\xd1\x8e\xd1\x87\xd0\xb5\xd0\xbd", 2);
            end;
            return; 
        end;
        Qh[14] = "\xbay";
        local function r109(...)
            H = r26;
            v1 = H[2];
            j = H[3];
            H = "ipairs";
            for j, Q in ipairs(H.GetDescendants(H)) do
                e = j;
                v7 = r16;
                v4 = "Tool";
                v5 = Q.IsA(Q, v4);
                if v5 then
                    v5 = Q.Name;
                    v4 = v5.lower(v5);
                    v7 = v4.find(v4, "gun");
                    v2 = v7;
                    if v7 then
                    end;
                end; 
            end;
            return nil; 
        end;
        local function r110(...)
            if r43.GrabGunRunning then
                return;
            end;
            r43.GrabGunRunning = true;
            if not r34.Character then
                r38("Grab Gun", "\xd0\x9f\xd0\xb5\xd1\x80\xd1\x81\xd0\xbe\xd0\xbd\xd0\xb0\xd0\xb6 \xd0\xbd\xd0\xb5 \xd0\xbd\xd0\xb0\xd0\xb9\xd0\xb4\xd0\xb5\xd0\xbd", 2);
                r43.GrabGunRunning = false;
                return;
            end;
            v5 = r34.Character;
            v1 = v5.FindFirstChild(v5, "HumanoidRootPart");
            if not v1 then
                r38("Grab Gun", "HRP \xd0\xbd\xd0\xb5 \xd0\xbd\xd0\xb0\xd0\xb9\xd0\xb4\xd0\xb5\xd0\xbd", 2);
                r43.GrabGunRunning = false;
                return;
            end;
            H = r109();
            if not H then
                r38("Grab Gun", "\xd0\x9e\xd1\x80\xd1\x83\xd0\xb6\xd0\xb8\xd0\xb5 \xd0\xbd\xd0\xb5 \xd0\xbd\xd0\xb0\xd0\xb9\xd0\xb4\xd0\xb5\xd0\xbd\xd0\xbe", 2);
                r43.GrabGunRunning = false;
                return;
            end;
            e = H.FindFirstChild(H, "Handle");
            if not e then
                r38("Grab Gun", "\xd0\x9d\xd0\xb5\xd1\x82 Handle", 2);
                r43.GrabGunRunning = false;
                return;
            end;
            v1.CFrame = e.CFrame * CFrame.new(0, 2, 2);
            task.wait(.1);
            v3 = v1.CFrame;
            v1.CFrame = v3;
            v5 = r34.Character;
            Q = v5.FindFirstChildOfClass(v5, "Humanoid");
            if Q then
                v5 = r34.Character;
                v4 = v5.FindFirstChildOfClass(v5, "Tool");
                if not v4 then
                    v3.EquipTool(v3, H);
                    r38("Grab Gun", "\xd0\x9f\xd0\xbe\xd0\xb4\xd0\xbe\xd0\xb1\xd1\x80\xd0\xb0\xd0\xbd\xd0\xbe: " .. H.Name, 2);
                end;
            end;
            r43.GrabGunRunning = false;
            return; 
        end;
        Qh[31] = 11815042225533;
        Qh[2] = function(...)
            e = r43;
            H = e.Tracers;
            v1 = e[2];
            H = e[1];
            for j, Q in pairs(H) do
                e = j;
                r111 = Q;
                pcall(function(...)
                    v5 = r111;
                    v5.Remove(v5);
                    return; 
                end); 
            end;
            r43.Tracers = {};
            return; 
        end;
        local function r112(...)
            r42.GrabGunEnabled = not r42.GrabGunEnabled;
            if r42.GrabGunEnabled then
                r110();
                r42.GrabGunEnabled = false;
            end;
            return; 
        end;
        Qh[23] = 33348106566824;
        Qh[12] = "\xc8\x1d\xb1H\x15\x11\xe6\xd2\x03f\x86";
        Qh[26] = 31367442348302;
        Qh[30] = 33597390830877;
        local function r113(...)
            while r42.SheriffAutoShootEnabled do
                task.wait(.05);
                if not r34.Character then
                    
                else
                    if not r48(r34) then
                        
                    else
                        v5 = r34.Character;
                        if not v5.FindFirstChild(v5, "HumanoidRootPart") then
                            
                        end;
                        e = "huge";
                        H = math[e];
                        v4 = r24;
                        Q = v4[3];
                        v4 = v4[1];
                        for Q, v7 in v4, ipairs(v4.GetPlayers(v4)) do
                            v2 = Q;
                            if v7 == r34 then
                                
                            else
                                if not v7.Character then
                                    
                                else
                                    if r47(v7) and r55(v7) then
                                        v5 = v7.Character;
                                        y = v5.FindFirstChild(v5, "HumanoidRootPart");
                                        if y then
                                            v5 = (v5.FindFirstChild(v5, "HumanoidRootPart").Position - y.Position).Magnitude;
                                            if v5 < math[e] and v5 <= 100 then
                                                v5 = v5;
                                                H = v5;
                                                j = v7;
                                            end;
                                        end;
                                    end;
                                end;
                            end; 
                        end;
                        if nil then
                            e = nil.Character;
                            Q = e.FindFirstChild(e, "HumanoidRootPart");
                            if Q then
                                e = Q.Position;
                                r35.CFrame = CFrame.lookAt(r35.CFrame.Position, e);
                                r56(r35.CFrame.Position, e, Color3.fromRGB(180, 50, 255), .2);
                                pcall(function(...)
                                    v5 = r30;
                                    v5.SendKeyEvent(v5, true, Enum.KeyCode.MouseButton1, false, game);
                                    task.wait(.05);
                                    v5 = r30;
                                    v5.SendKeyEvent(v5, false, Enum.KeyCode.MouseButton1, false, game);
                                    return; 
                                end);
                                task.wait(.3);
                            end;
                        end;
                    end;
                end; 
            end;
            return; 
        end;
        local function r114(arg1_40, ...)
            v1 = arg1_40;
            j = v1;
            r42.SheriffAutoShootEnabled = j;
            r45(r43.SheriffAutoShootConnection);
            r43.SheriffAutoShootConnection = nil;
            if v1 then
                r43.SheriffAutoShootConnection = task.spawn(r113);
                r38("Sheriff AutoShoot", "\xd0\x92\xd0\xba\xd0\xbb\xd1\x8e\xd1\x87\xd0\xb5\xd0\xbd", 2);
            else
                r38("Sheriff AutoShoot", "\xd0\x92\xd1\x8b\xd0\xba\xd0\xbb\xd1\x8e\xd1\x87\xd0\xb5\xd0\xbd", 2);
            end;
            return; 
        end;
        Qh[4] = function(...)
            if r43.TrailAttachments.trail then
                pcall(function(...)
                    v5 = r43.TrailAttachments.trail;
                    v5.Destroy(v5);
                    return; 
                end);
            end;
            if r43.TrailAttachments.att1 then
                pcall(function(...)
                    v5 = r43.TrailAttachments.att1;
                    v5.Destroy(v5);
                    return; 
                end);
            end;
            if r43.TrailAttachments.att2 then
                pcall(function(...)
                    v5 = r43.TrailAttachments.att2;
                    v5.Destroy(v5);
                    return; 
                end);
            end;
            r43.TrailAttachments = {};
            return; 
        end;
        local function r115(...)
            r45(r43.WallHopConnection);
            r43.WallHopConnection = nil;
            if not r42.WallHopEnabled then
                return;
            end;
            v1 = r25.Heartbeat;
            r43.WallHopConnection = v1.Connect(v1, function(...)
                if not r34.Character then
                    return;
                end;
                v5 = r34.Character;
                v1 = v5.FindFirstChildOfClass(v5, "Humanoid");
                if not v1 then
                    return;
                end;
                v5 = r27;
                if v5.IsKeyDown(v5, Enum.KeyCode.Space) then
                    v1.ChangeState(v1, Enum.HumanoidStateType.Jumping);
                end;
                return; 
            end);
            return; 
        end;
        local function r116(arg1_41, ...)
            v1 = arg1_41;
            r42.WallHopEnabled = v1;
            if v1 then
                r115();
                r38("Wall Hop", "\xd0\x92\xd0\xba\xd0\xbb\xd1\x8e\xd1\x87\xd0\xb5\xd0\xbd (\xd0\xb7\xd0\xb0\xd0\xb6\xd0\xbc\xd0\xb8 Space)", 2);
            else
                r45(r43.WallHopConnection);
                r43.WallHopConnection = nil;
                r38("Wall Hop", "\xd0\x92\xd1\x8b\xd0\xba\xd0\xbb\xd1\x8e\xd1\x87\xd0\xb5\xd0\xbd", 2);
            end;
            return; 
        end;
        local function r117(arg1_42, ...)
            v1 = arg1_42;
            if not v1 or not v1.Character then
                return;
            end;
            Q = v1.Character;
            H = Q[2];
            e = Q[3];
            Q = "ipairs";
            for e, v2 in ipairs(Q.GetDescendants(Q)) do
                v4 = e;
                if v2.IsA(v2, "BasePart") and v2.Name ~= "HumanoidRootPart" then
                    ({})[v2] = {
                        ["ogMaterial"] = v2.Material,
                        ["ogColor"] = v2.Color,
                        ["ogTransparency"] = v2.Transparency,
                        ["ogCastShadow"] = v2.CastShadow
                    };
                end; 
            end;
            r43.ChamsPartsList[v1.UserId] = {};
            return; 
        end;
        Qh[19] = 720444014927;
        Qh[57] = 31829121202661;
        local function r118(...)
            j = ({
                ["Purple"] = Color3.fromRGB(138, 43, 226),
                ["Blue"] = Color3.fromRGB(0, 100, 255),
                ["Red"] = Color3.fromRGB(255, 0, 0),
                ["Green"] = Color3.fromRGB(0, 255, 0)
            })[r42.ChamsColor];
            if j then
                return j;
            else
                v3 = Color3.fromRGB(138, 43, 226);
            end; 
        end;
        Qh[41] = 24143944723434;
        Qh[6] = function(arg1_43, ...)
            v5 = r28;
            v1 = arg1_43;
            H = v5;
            v3 = "Ambient";
            e = v1;
            if v1 then
                e = r44.Purple;
            end;
            j = e;
            v5 = v5;
            if e then
                v5 = v5;
                v5[r15[r16("<\xf8\xd95\x19\xcf\xcd", v4)]] = e;
                v5 = r28;
                e = arg1_43;
                v5 = v5;
                if e then
                    v5 = v5;
                    v5.OutdoorAmbient = e and r44.Purple;
                    return;
                else
                    j = Color3.fromRGB(0, 0, 0);
                end;
            else
                j = Color3.fromRGB(0, 0, 0);
            end; 
        end;
        local function r119(arg1_44, ...)
            v1 = arg1_44;
            if not v1 or not v1.Character then
                return;
            end;
            j = v1.Character;
            r120 = j.FindFirstChild(j, "PH_Chams");
            if r120 then
                pcall(function(...)
                    v5 = r120;
                    v5.Destroy(v5);
                    return; 
                end);
            end;
            v6 = 22434039425230;
            if not r43.ChamsPartsList[v1[r15[r16("4U\xba\xc0\xb4\x02", v6)]]] then
                r117(v1);
            end;
            r118();
            v7 = j.GetDescendants;
            v2 = {
                v7(j)
            };
            Q = v7[2];
            v2 = v7[1];
            for v4, y in ipairs(C(v2)) do
                v6 = y.IsA(y, "BasePart");
                v7 = v4;
                if v6 then
                    w = y.Name ~= "HumanoidRootPart";
                end;
                if v6 then
                    if not r43.ChamsPartsList[v1.UserId] then
                        r43.ChamsPartsList[arg1_44.UserId] = {};
                    end;
                    if not r43.ChamsPartsList[v1.UserId][y] then
                        r43.ChamsPartsList[arg1_44.UserId][y] = {
                            ["ogMaterial"] = y.Material,
                            ["ogColor"] = y.Color,
                            ["ogTransparency"] = y.Transparency,
                            ["ogCastShadow"] = y.CastShadow
                        };
                    end;
                    y.Material = Enum.Material.ForceField;
                    w = r118();
                    y.Color = w;
                    y.Transparency = 0;
                    y.CastShadow = false;
                end; 
            end;
            return; 
        end;
        Qh[18] = 5858136607399;
        local function r121(arg1_45, ...)
            v1 = arg1_45;
            if not v1 or not v1.Character then
                return;
            end;
            j = v1.Character;
            r122 = j.FindFirstChild(j, "PH_Chams");
            if r122 then
                pcall(function(...)
                    v5 = r122;
                    v5.Destroy(v5);
                    return; 
                end);
            end;
            v2 = r16;
            e = r43.ChamsPartsList[v1.UserId];
            if not e then
                return;
            end;
            v4 = v2[3];
            v2 = v2[1];
            for v4, y in v2, pairs(e) do
                r123 = v4;
                r124 = y;
                v6 = r123;
                if v6 then
                    w = r123.Parent;
                end;
                if v6 then
                    pcall(function(...)
                        r123.Material = A[v5].ogMaterial;
                        r123.Color = A[v5].ogColor;
                        r123.Transparency = A[v5].ogTransparency;
                        r123.CastShadow = A[v5].ogCastShadow;
                        return; 
                    end);
                end; 
            end;
            r43.ChamsPartsList[v1.UserId] = nil;
            return; 
        end;
        Qh[15] = 9590518518129;
        local function r125(...)
            v5 = pairs;
            e = r43;
            H = e.ChamsPartsList;
            j = e[3];
            H = e[1];
            for j, Q in H, v5(H) do
                v5 = r24;
                v4 = v5.GetPlayerByUserId(v5, j);
                if v4 then
                    r121(v4);
                end; 
            end;
            r43.ChamsPartsList = {};
            return; 
        end;
        Qh[20] = 17412657422252;
        local function r126(...)
            if r42.ChamsEnabled then
                H = r24;
                v1 = H[2];
                j = H[3];
                H = "ipairs";
                for j, Q in ipairs(H.GetPlayers(H)) do
                    e = j;
                    r117(Q);
                    r119(Q); 
                end;
            else
                r125();
            end;
            return; 
        end;
        Qh[3] = function(...)
            v1 = r34.Character;
            if not v1 then
                return;
            end;
            j = v1.FindFirstChild(v1, "HumanoidRootPart");
            if not j then
                return;
            end;
            if r43.TrailAttachments.trail and r43.TrailAttachments.trail.Parent then
                return;
            end;
            H = Instance.new("Attachment");
            H.Position = Vector3.new(-1, 0, 0);
            H.Parent = j;
            e = Instance.new("Attachment");
            e.Position = Vector3.new(1, 0, 0);
            e.Parent = j;
            Q = Instance.new("Trail");
            Q.Attachment0 = H;
            Q.Attachment1 = e;
            Q.Lifetime = .8;
            Q.MinLength = 0;
            Q.FaceCamera = true;
            Q.LightEmission = 1;
            Q.LightInfluence = 0;
            Q.Transparency = NumberSequence.new({
                NumberSequenceKeypoint.new(0, 0),
                NumberSequenceKeypoint.new(1, 1)
            });
            Q.Color = ColorSequence.new(r44.Purple);
            Q.Parent = j;
            r43.TrailAttachments = {
                ["trail"] = Q,
                ["att1"] = H,
                ["att2"] = e
            };
            return; 
        end;
        local function r127(arg1_46, arg2_46, ...)
            v1 = arg1_46;
            H = not v1;
            v3 = H;
            j = arg2_46;
            if H then
                if v3 then
                    return;
                end;
                Q = r16;
                H = v1.Character;
                e = H.FindFirstChild(H, "PH_ESP");
                if not e then
                    e = Instance.new("Highlight");
                    e.Name = "PH_ESP";
                    e.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop;
                    Q = v1.Character;
                    e.Parent = Q;
                end;
                Q = j;
                e.FillColor = Q;
                e.OutlineColor = j;
                e.FillTransparency = .4;
                e.OutlineTransparency = 0;
                e.Enabled = true;
                r43.Highlights[v1.UserId] = e;
                return;
            else
                v3 = not v1.Character;
            end; 
        end;
        local function r128(arg1_47, ...)
            v1 = arg1_47;
            if not v1 or not v1.Character then
                return;
            end;
            v5 = v1.Character;
            r129 = v5.FindFirstChild(v5, "PH_ESP");
            if r129 then
                pcall(function(...)
                    v5 = r129;
                    v5.Destroy(v5);
                    return; 
                end);
            end;
            r43.Highlights[v1.UserId] = nil;
            return; 
        end;
        local function r130(...)
            e = r43;
            H = e.Highlights;
            v1 = e[2];
            H = e[1];
            for j, Q in pairs(H) do
                e = j;
                r131 = Q;
                if r131 then
                    pcall(function(...)
                        v5 = r131;
                        v5.Destroy(v5);
                        return; 
                    end);
                end; 
            end;
            r43.Highlights = {};
            return; 
        end;
        Qh[17] = 2552664851620;
        local function r132(arg1_48, ...)
            v1 = arg1_48;
            if not v1 or v1 == r34 then
                return;
            end;
            if r43.Tracers[v1.UserId] then
                return;
            end;
            j = Drawing.new("Line");
            j.Thickness = 2;
            j.Transparency = .8;
            j.Visible = false;
            j.Color = r50(v1);
            r43.Tracers[v1.UserId] = j;
            return; 
        end;
        r133 = Qh[1];
        Qh[1] = 167;
        A[Qh[1]] = Qh[2];
        Qh[2] = 168;
        A[Qh[2]] = Qh[3];
        Qh[16] = 34190145928753;
        Qh[3] = 169;
        A[Qh[3]] = Qh[4];
        Qh[13] = 6992499936440;
        Qh[4] = 170;
        A[Qh[4]] = Qh[5];
        Qh[5] = 171;
        A[Qh[5]] = Qh[6];
        Qh[6] = 172;
        A[Qh[6]] = Qh[7];
        Qh[9] = r15;
        Qh[10] = r16;
        Qh[11] = Qh[10](Qh[12], Qh[13]);
        Qh[8] = Qh[9][Qh[11]];
        Qh[11] = r15;
        Qh[12] = r16;
        Qh[13] = Qh[12](Qh[14], Qh[15]);
        Qh[10] = Qh[11][Qh[13]];
        Qh[12] = r15;
        Qh[13] = r16;
        Qh[34] = 26072363741036;
        Qh[15] = "(\xed\xc9\x17\xcf\xc6\r\xfe\xb9\x15\xd4h\xcf\x17\xd57\x1b\xe0\x84|N\x19C1";
        Qh[14] = Qh[13](Qh[15], Qh[16]);
        Qh[11] = Qh[12][Qh[14]];
        Qh[16] = "\x00\xa4";
        Qh[13] = r15;
        Qh[14] = r16;
        Qh[15] = Qh[14](Qh[16], Qh[17]);
        Qh[12] = Qh[13][Qh[15]];
        Qh[14] = r15;
        Qh[15] = r16;
        Qh[17] = "\xa8j\x1ad\xb1\x1f\x14\xbb\xdeA\x07\xd9\xd6\xf5\xb4\xd2\xe6W\xaa5\xac\x82\xad\xaf";
        Qh[16] = Qh[15](Qh[17], Qh[18]);
        Qh[13] = Qh[14][Qh[16]];
        Qh[15] = r15;
        Qh[18] = "\x17o";
        Qh[21] = 5066418194743;
        Qh[16] = r16;
        Qh[17] = Qh[16](Qh[18], Qh[19]);
        Qh[14] = Qh[15][Qh[17]];
        Qh[22] = 20658517484947;
        Qh[19] = "u\xcd\xcc\xd8q}\x84\xa2s\xae\xd7&\xc9\xf5\xad\x08)>T\x9f\xa1gi:";
        Qh[16] = r15;
        Qh[17] = r16;
        Qh[18] = Qh[17](Qh[19], Qh[20]);
        Qh[15] = Qh[16][Qh[18]];
        Qh[17] = r15;
        Qh[18] = r16;
        Qh[20] = ">\xd8";
        Qh[19] = Qh[18](Qh[20], Qh[21]);
        Qh[16] = Qh[17][Qh[19]];
        Qh[18] = r15;
        Qh[19] = r16;
        Qh[21] = "\x86\xd0\xb4\xddRY\xda\xbc\xb8\xa0-\x8b\xb0oZ\x14\xa1\x93\x81VK\xb8\xb1\xe6";
        Qh[20] = Qh[19](Qh[21], Qh[22]);
        Qh[17] = Qh[18][Qh[20]];
        Qh[19] = r15;
        Qh[28] = 34256755031632;
        Qh[20] = r16;
        Qh[22] = "s\x1a";
        Qh[21] = Qh[20](Qh[22], Qh[23]);
        Qh[18] = Qh[19][Qh[21]];
        Qh[23] = "[\x18\xef\xd9\x1f:\xad%P\x85\x85\xeb\xa0\xe3f\x1f\xcf\x15\xc2f\x9a\x9c\x05\xa9";
        Qh[20] = r15;
        Qh[21] = r16;
        Qh[22] = Qh[21](Qh[23], Qh[24]);
        Qh[24] = " T";
        Qh[19] = Qh[20][Qh[22]];
        Qh[21] = r15;
        Qh[22] = r16;
        Qh[23] = Qh[22](Qh[24], Qh[25]);
        Qh[20] = Qh[21][Qh[23]];
        Qh[22] = r15;
        Qh[25] = "\xb8\xcd\xa4:\xf7\xb36\xdf\x85%\x7f\xc3(K\xf2\xb7\xacsx\xa4W\xcd\xc3\xf8";
        Qh[23] = r16;
        Qh[39] = 16660758945358;
        Qh[24] = Qh[23](Qh[25], Qh[26]);
        Qh[23] = 8345214045998;
        Qh[21] = Qh[22][Qh[24]];
        Qh[9] = {
            [Qh[10]] = Qh[11],
            [Qh[12]] = Qh[13],
            [Qh[14]] = Qh[15],
            [Qh[16]] = Qh[17],
            [Qh[18]] = Qh[19],
            [Qh[20]] = Qh[21]
        };
        Qh[15] = 1765826921270;
        Qh[14] = "0F";
        Qh[11] = r15;
        Qh[12] = r16;
        Qh[13] = Qh[12](Qh[14], Qh[15]);
        Qh[17] = 24889655438662;
        Qh[24] = 20066834932864;
        Qh[10] = Qh[11][Qh[13]];
        Qh[13] = r15;
        Qh[16] = "Q\x05";
        Qh[14] = r16;
        Qh[20] = 19675449205706;
        Qh[15] = Qh[14](Qh[16], Qh[17]);
        Qh[12] = Qh[13][Qh[15]];
        Qh[22] = 24790674468120;
        Qh[17] = "@O\x1b\x11\x1d\x9d,\xcd\xed\x998~=\x18\xb4\xb0\x1dL\r\xfe\xdck\xbd\xa5z=\xe2F\xbaa\xea\xcfQ\x93$\x1dH~\x9c<4\xd5\xb9";
        Qh[18] = 1310527963746;
        Qh[19] = 10614226604878;
        Qh[14] = r15;
        Qh[15] = r16;
        Qh[16] = Qh[15](Qh[17], Qh[18]);
        Qh[13] = Qh[14][Qh[16]];
        Qh[21] = 6709023362100;
        Qh[15] = r15;
        Qh[26] = 27913414619846;
        Qh[18] = "3\xf8";
        Qh[16] = r16;
        Qh[43] = 28955519825067;
        Qh[17] = Qh[16](Qh[18], Qh[19]);
        Qh[14] = Qh[15][Qh[17]];
        Qh[16] = r15;
        Qh[40] = 31170898491571;
        Qh[19] = "\xc6\x1a\xf9\xec\xff\xd5\xe8\x0eJ\x91\x97\"\xde\xde\x91=\x82\x08\xe6*\x0b\x03\x91\xa5\x97=\xab\x1b\xc4\x9aZ\xb5\x9cd\xbf\xb2\xdf[\x18\x8cke\xb6";
        Qh[17] = r16;
        Qh[27] = 18151868784900;
        Qh[18] = Qh[17](Qh[19], Qh[20]);
        Qh[15] = Qh[16][Qh[18]];
        Qh[32] = 3758548616918;
        Qh[17] = r15;
        Qh[20] = "\x0f#";
        Qh[18] = r16;
        Qh[19] = Qh[18](Qh[20], Qh[21]);
        Qh[16] = Qh[17][Qh[19]];
        Qh[18] = r15;
        Qh[19] = r16;
        Qh[21] = "XV\xbe\x848\xeeV\xde\xf6\xf1\xf6TQ\x08\xcai\xa5\x0bz\x08\x87\xb8\x84\xe7\x93`\xd9\x01\x1d\x1b\x9f\x99\x07\x874\x0c\xf6\xe8\xd6\xaa\xa7\xc5{";
        Qh[20] = Qh[19](Qh[21], Qh[22]);
        Qh[17] = Qh[18][Qh[20]];
        Qh[19] = r15;
        Qh[20] = r16;
        Qh[22] = "`\xd8";
        Qh[21] = Qh[20](Qh[22], Qh[23]);
        Qh[18] = Qh[19][Qh[21]];
        Qh[20] = r15;
        Qh[23] = "\xd2m\xaf\x05q\x7f\xfa\x18\x00\xf92\xac\xe3\xfd\x1alc\xfa\x86\xf5\x17\xaac\xb1\x00\xdf\x818]\xed\xd6\xae\x17zu\x89[A\xe6\xb98n}";
        Qh[21] = r16;
        Qh[22] = Qh[21](Qh[23], Qh[24]);
        Qh[25] = 23071821277687;
        Qh[19] = Qh[20][Qh[22]];
        Qh[21] = r15;
        Qh[22] = r16;
        Qh[24] = "J1";
        Qh[23] = Qh[22](Qh[24], Qh[25]);
        Qh[20] = Qh[21][Qh[23]];
        Qh[22] = r15;
        Qh[23] = r16;
        Qh[25] = "\x06\xeb7\xb6K5\xce\xd5\xb6B\x9fhz\xb5\xa6K\xd1\x8d\xcf\x80\xaaN\xcel9\x9eF\x83\x16a\x0c\xd6\xb0\x1b\xd7f\x8d\xcf\x0e\xb13wE";
        Qh[24] = Qh[23](Qh[25], Qh[26]);
        Qh[21] = Qh[22][Qh[24]];
        Qh[26] = "\xea:";
        Qh[23] = r15;
        Qh[24] = r16;
        Qh[25] = Qh[24](Qh[26], Qh[27]);
        Qh[22] = Qh[23][Qh[25]];
        Qh[24] = r15;
        Qh[25] = r16;
        Qh[27] = "8\x04\x10\xa1\xf0\x8b\xb0f\x87\x98\xb9EV0.X\xac\xb7\xbf\xcfVM5\xb5\xc8\x9d@\xa6\x017W\xff\xcf9R\xe4\xde!\x05&77_";
        Qh[26] = Qh[25](Qh[27], Qh[28]);
        Qh[29] = 24161410132979;
        Qh[23] = Qh[24][Qh[26]];
        Qh[11] = {
            [Qh[12]] = Qh[13],
            [Qh[14]] = Qh[15],
            [Qh[16]] = Qh[17],
            [Qh[18]] = Qh[19],
            [Qh[20]] = Qh[21],
            [Qh[22]] = Qh[23]
        };
        Qh[18] = "^\xd0";
        Qh[21] = 13082317494219;
        Qh[19] = 7889405988441;
        Qh[16] = "\x97N\xca\x91";
        Qh[13] = r15;
        Qh[14] = r16;
        Qh[20] = 32387960011497;
        Qh[17] = 27085022409028;
        Qh[15] = Qh[14](Qh[16], Qh[17]);
        Qh[22] = 29991915157134;
        Qh[12] = Qh[13][Qh[15]];
        Qh[15] = r15;
        Qh[16] = r16;
        Qh[17] = Qh[16](Qh[18], Qh[19]);
        Qh[14] = Qh[15][Qh[17]];
        Qh[19] = "\xc2/\x1a\x18*[\x9e#\xd9\x932T\x92ob\xf3C\xc4\xa83\xe4\x98\xfdD\xe7\xc3\x0f(\xfe\x91\x17je\x0e'\xd8\r\xa2#\xaa\xf6";
        Qh[16] = r15;
        Qh[17] = r16;
        Qh[18] = Qh[17](Qh[19], Qh[20]);
        Qh[20] = "&<";
        Qh[15] = Qh[16][Qh[18]];
        Qh[17] = r15;
        Qh[27] = 28530972636133;
        Qh[49] = 25177823620556;
        Qh[18] = r16;
        Qh[19] = Qh[18](Qh[20], Qh[21]);
        Qh[23] = 4196087842721;
        Qh[16] = Qh[17][Qh[19]];
        Qh[51] = 20380192220434;
        Qh[18] = r15;
        Qh[21] = "\xab\xb3\x80\x97s25`\xe7d\x05)\xba\x07 }\x91\xb0EN\x13\xcc\xbd*\xa8\xe6\xf1\xdd\xc5\xd1M\xc4\xdeY\xfd[\\iZI\xe3";
        Qh[37] = 20766551418310;
        Qh[19] = r16;
        Qh[20] = Qh[19](Qh[21], Qh[22]);
        Qh[25] = 28997688997055;
        Qh[17] = Qh[18][Qh[20]];
        Qh[19] = r15;
        Qh[24] = 22672836028733;
        Qh[22] = "\xbc?";
        Qh[20] = r16;
        Qh[21] = Qh[20](Qh[22], Qh[23]);
        Qh[28] = 29718133011982;
        Qh[18] = Qh[19][Qh[21]];
        Qh[20] = r15;
        Qh[21] = r16;
        Qh[23] = "\xd1L\xa5Q\xa3\x86#\xfc\x1c\x1at0x\x04P\x9f\xeb\xab\xf6FT`\x8c\xa17d\xab\xfd|\xeb\xe9\xae\x1a\xae\x9d]\xd1\x0e\xc8m2";
        Qh[22] = Qh[21](Qh[23], Qh[24]);
        Qh[19] = Qh[20][Qh[22]];
        Qh[26] = 6748752694342;
        Qh[21] = r15;
        Qh[22] = r16;
        Qh[24] = "!r";
        Qh[23] = Qh[22](Qh[24], Qh[25]);
        Qh[25] = "O\xa4z\xc1tn-\x9e\x9e\x91\xd7T\xb5/a\xff\xdc\x16\xac^i.<\x84@[4\x13-\x8d\x7f\xdc\xebQ]\x01\xb9_\xff\xb9\xa0";
        Qh[20] = Qh[21][Qh[23]];
        Qh[22] = r15;
        Qh[23] = r16;
        Qh[24] = Qh[23](Qh[25], Qh[26]);
        Qh[21] = Qh[22][Qh[24]];
        Qh[23] = r15;
        Qh[24] = r16;
        Qh[26] = "\x82\x14";
        Qh[25] = Qh[24](Qh[26], Qh[27]);
        Qh[27] = "!\xbd\xd1\xab\x92\x15`c\xfa$\xb5*(\xe6\x0c]\xfc\x9b\xcejih\x03C\xdc\x8cp\xc91\xb9\xd7\xcb\x98-\xbc\x0b=\x1d\xd1\x97\xc9";
        Qh[22] = Qh[23][Qh[25]];
        Qh[24] = r15;
        Qh[25] = r16;
        Qh[26] = Qh[25](Qh[27], Qh[28]);
        Qh[23] = Qh[24][Qh[26]];
        Qh[25] = r15;
        Qh[26] = r16;
        Qh[28] = "t\x80";
        Qh[27] = Qh[26](Qh[28], Qh[29]);
        Qh[29] = "\x95d|f\x904\xea$\x94\x026\xf0\xca\x04\x89~G\xcd8\xd3\xf1y.64\x9fx\xfdj4\x12\x1f\xe6\xd9\x9f|\x9c1\xed\xc6)";
        Qh[24] = Qh[25][Qh[27]];
        Qh[26] = r15;
        Qh[27] = r16;
        Qh[28] = Qh[27](Qh[29], Qh[30]);
        Qh[25] = Qh[26][Qh[28]];
        Qh[13] = {
            [Qh[14]] = Qh[15],
            [Qh[16]] = Qh[17],
            [Qh[18]] = Qh[19],
            [Qh[20]] = Qh[21],
            [Qh[22]] = Qh[23],
            [Qh[24]] = Qh[25]
        };
        Qh[30] = 26527766179904;
        Qh[15] = r15;
        Qh[18] = "'\xf4\xba\xaa\x0f\xb6\x08\xc9=\xbc";
        Qh[19] = 15192278391714;
        Qh[16] = r16;
        Qh[24] = 18508214837674;
        Qh[22] = 9828686336480;
        Qh[17] = Qh[16](Qh[18], Qh[19]);
        Qh[14] = Qh[15][Qh[17]];
        Qh[17] = r15;
        Qh[26] = 10922257470430;
        Qh[21] = 22325144594587;
        Qh[25] = 11594513257751;
        Qh[18] = r16;
        Qh[20] = "f\xf4";
        Qh[27] = 19818742801420;
        Qh[28] = 22208739862629;
        Qh[19] = Qh[18](Qh[20], Qh[21]);
        Qh[16] = Qh[17][Qh[19]];
        Qh[18] = r15;
        Qh[21] = "\x00\x9b\xf5\xca5\x01\xd0Sxc\xbc~\x8a\xed\xce\x9ac.\x83\xd2\xf2V[\xae";
        Qh[19] = r16;
        Qh[20] = Qh[19](Qh[21], Qh[22]);
        Qh[17] = Qh[18][Qh[20]];
        Qh[19] = r15;
        Qh[23] = 21216974120599;
        Qh[20] = r16;
        Qh[22] = "\xa6L";
        Qh[21] = Qh[20](Qh[22], Qh[23]);
        Qh[18] = Qh[19][Qh[21]];
        Qh[20] = r15;
        Qh[21] = r16;
        Qh[23] = "\x11\xc7\xfa\xb4\xd2\xad\xfc\xd10!\xaa\xd9\r\x847\xf4\xae\xedC\xa9\xd2\xe1\xbd=";
        Qh[22] = Qh[21](Qh[23], Qh[24]);
        Qh[19] = Qh[20][Qh[22]];
        Qh[24] = "\x8d\xc1";
        Qh[21] = r15;
        Qh[22] = r16;
        Qh[23] = Qh[22](Qh[24], Qh[25]);
        Qh[25] = ":\xf3\r_\xf0\x94\xf2\xc3F\xcd\x03\xc0\x1e\x93\x07^\x8e_\x9cm\x9f\x9fA^";
        Qh[20] = Qh[21][Qh[23]];
        Qh[22] = r15;
        Qh[23] = r16;
        Qh[29] = 30597706676136;
        Qh[24] = Qh[23](Qh[25], Qh[26]);
        Qh[21] = Qh[22][Qh[24]];
        Qh[23] = r15;
        Qh[26] = "\x1cj";
        Qh[24] = r16;
        Qh[25] = Qh[24](Qh[26], Qh[27]);
        Qh[22] = Qh[23][Qh[25]];
        Qh[24] = r15;
        Qh[27] = "\x0cx\x85\xec\x80\\(\xe4~ a\xad\x84J\xa6nn\xf3\xb6K\xd5\xa3\xe8\xa2";
        Qh[25] = r16;
        Qh[26] = Qh[25](Qh[27], Qh[28]);
        Qh[23] = Qh[24][Qh[26]];
        Qh[28] = "\xc0\xb4";
        Qh[25] = r15;
        Qh[26] = r16;
        Qh[27] = Qh[26](Qh[28], Qh[29]);
        Qh[24] = Qh[25][Qh[27]];
        Qh[26] = r15;
        Qh[29] = "\xb0z\x8ff\x0b\x0bk\xf3\x0f:~\x1b\xcf\xe4\x1c\xa6\x01j\xc5\xcc\xcfA\x91\xf3";
        Qh[27] = r16;
        Qh[28] = Qh[27](Qh[29], Qh[30]);
        Qh[25] = Qh[26][Qh[28]];
        Qh[27] = r15;
        Qh[30] = "\x98\xeb";
        Qh[28] = r16;
        Qh[29] = Qh[28](Qh[30], Qh[31]);
        Qh[31] = ",6\xfb\x8e\x8b6gQ\xca\x95\x118'\x83\xe8\x8a\xaa\xb3E|+\xae\xee5";
        Qh[26] = Qh[27][Qh[29]];
        Qh[28] = r15;
        Qh[29] = r16;
        Qh[30] = Qh[29](Qh[31], Qh[32]);
        Qh[27] = Qh[28][Qh[30]];
        Qh[15] = {
            [Qh[16]] = Qh[17],
            [Qh[18]] = Qh[19],
            [Qh[20]] = Qh[21],
            [Qh[22]] = Qh[23],
            [Qh[24]] = Qh[25],
            [Qh[26]] = Qh[27]
        };
        Qh[17] = r15;
        Qh[18] = r16;
        Qh[20] = "\x8d\x93\xa2\x1cU\xb2\xe9a\xd4";
        Qh[21] = 11410229007553;
        Qh[27] = 23572613556960;
        Qh[19] = Qh[18](Qh[20], Qh[21]);
        Qh[24] = 31671963253148;
        Qh[25] = 29562097792453;
        Qh[23] = 34886863519605;
        Qh[16] = Qh[17][Qh[19]];
        Qh[19] = r15;
        Qh[20] = r16;
        Qh[22] = "\x99\x83";
        Qh[21] = Qh[20](Qh[22], Qh[23]);
        Qh[18] = Qh[19][Qh[21]];
        Qh[29] = 31162834352303;
        Qh[20] = r15;
        Qh[23] = "U\x86\xf80D@tC\xc9\x9d\x16\xf6\xed\x1e\xa9\xf5-*G\xaaV\x8e";
        Qh[21] = r16;
        Qh[30] = 1470558962348;
        Qh[22] = Qh[21](Qh[23], Qh[24]);
        Qh[19] = Qh[20][Qh[22]];
        Qh[31] = 32259046849197;
        Qh[24] = "\xb2U";
        Qh[21] = r15;
        Qh[22] = r16;
        Qh[26] = 33959246446021;
        Qh[23] = Qh[22](Qh[24], Qh[25]);
        Qh[20] = Qh[21][Qh[23]];
        Qh[28] = 2267131675679;
        Qh[36] = 21368070973150;
        Qh[22] = r15;
        Qh[25] = "\xb5\x057?\x02g\x1c\xec\x13,\xafS\xf1D\x8c\x91\xee\xaf\x98\xd5\xc9\r";
        Qh[23] = r16;
        Qh[24] = Qh[23](Qh[25], Qh[26]);
        Qh[21] = Qh[22][Qh[24]];
        Qh[26] = "\xd6\xa0";
        Qh[23] = r15;
        Qh[24] = r16;
        Qh[25] = Qh[24](Qh[26], Qh[27]);
        Qh[22] = Qh[23][Qh[25]];
        Qh[27] = "c\xef\xc5RM\x0fJ\x11\xc1\x9e\xf7\xe9\x100M6!\xc3)\xdb\x8b\xeb";
        Qh[24] = r15;
        Qh[25] = r16;
        Qh[26] = Qh[25](Qh[27], Qh[28]);
        Qh[23] = Qh[24][Qh[26]];
        Qh[28] = "A\x00";
        Qh[25] = r15;
        Qh[38] = 30621451876275;
        Qh[26] = r16;
        Qh[27] = Qh[26](Qh[28], Qh[29]);
        Qh[24] = Qh[25][Qh[27]];
        Qh[26] = r15;
        Qh[29] = "\xd2,\xaf\xf2 \x9263he'w\xd2\xe4\xdc]\xce\x1e\xc4>\xd3\xb6";
        Qh[27] = r16;
        Qh[28] = Qh[27](Qh[29], Qh[30]);
        Qh[32] = 174550106193;
        Qh[30] = "K\x08";
        Qh[25] = Qh[26][Qh[28]];
        Qh[27] = r15;
        Qh[28] = r16;
        Qh[29] = Qh[28](Qh[30], Qh[31]);
        Qh[26] = Qh[27][Qh[29]];
        Qh[28] = r15;
        Qh[31] = "\xb2g'#\x9eJ\xc8\xca\x82\x9cL\xc0\xf5w\x8do2\x84<\xe9\x83V";
        Qh[29] = r16;
        Qh[33] = 24143394991082;
        Qh[30] = Qh[29](Qh[31], Qh[32]);
        Qh[27] = Qh[28][Qh[30]];
        Qh[32] = "\x90\x90";
        Qh[29] = r15;
        Qh[30] = r16;
        Qh[31] = Qh[30](Qh[32], Qh[33]);
        Qh[28] = Qh[29][Qh[31]];
        Qh[33] = "\xa0\xb8\xd6a\x7fZ\x1e\xf9\\O=\x12\xa8t\xdf\xab\xe0\xe2\xd0\x8eN\x89";
        Qh[30] = r15;
        Qh[31] = r16;
        Qh[32] = Qh[31](Qh[33], Qh[34]);
        Qh[29] = Qh[30][Qh[32]];
        Qh[17] = {
            [Qh[18]] = Qh[19],
            [Qh[20]] = Qh[21],
            [Qh[22]] = Qh[23],
            [Qh[24]] = Qh[25],
            [Qh[26]] = Qh[27],
            [Qh[28]] = Qh[29]
        };
        Qh[19] = r15;
        Qh[22] = "\xb2Z\xe5c\xfc\xf7";
        Qh[23] = 6923302800535;
        Qh[20] = r16;
        Qh[21] = Qh[20](Qh[22], Qh[23]);
        Qh[18] = Qh[19][Qh[21]];
        Qh[26] = 20606124647803;
        Qh[24] = "k\xec";
        Qh[21] = r15;
        Qh[22] = r16;
        Qh[25] = 17489995522000;
        Qh[23] = Qh[22](Qh[24], Qh[25]);
        Qh[25] = "\xceW{\xec\x99\xc7\x9fb\x95\xd1\xb7\x87\xd7\x92\x9dNBX\xb7{\x00\"Y\xb7x\x97\x17\x8bu\x17\xc4\xcd\x9dFI\xa8)\xe3 F\xcd\x10\xea";
        Qh[29] = 614030950685;
        Qh[20] = Qh[21][Qh[23]];
        Qh[22] = r15;
        Qh[23] = r16;
        Qh[24] = Qh[23](Qh[25], Qh[26]);
        Qh[26] = "\xee\xba";
        Qh[42] = 32300632406721;
        Qh[50] = 25998608658250;
        Qh[21] = Qh[22][Qh[24]];
        Qh[27] = 31084712933514;
        Qh[23] = r15;
        Qh[24] = r16;
        Qh[25] = Qh[24](Qh[26], Qh[27]);
        Qh[27] = "\xe6[U\x16R\x81\x85\x12\xd1(\xc8<\xcfe\x01\x00\xbe8*\xdbY\xee\xe3Q\xc9\x8e\xb2tA@U\x85c\x9f\x02\xf9\x89E\x8bbV\xbc+";
        Qh[35] = 32753262541715;
        Qh[30] = 18225485422886;
        Qh[22] = Qh[23][Qh[25]];
        Qh[24] = r15;
        Qh[28] = 15903014264045;
        Qh[25] = r16;
        Qh[26] = Qh[25](Qh[27], Qh[28]);
        Qh[28] = "\xe4\xe4";
        Qh[23] = Qh[24][Qh[26]];
        Qh[25] = r15;
        Qh[34] = 2141841753061;
        Qh[32] = 21831005071285;
        Qh[26] = r16;
        Qh[27] = Qh[26](Qh[28], Qh[29]);
        Qh[29] = "W\\}\xa5\xefd\x10\xba0\xa3\xa1m\x05\xd7}\xe7\xc7\xbe\xd8c\xac_4\xb0\xc5\xa5m\xb0\xb7\x80\xcb.\x95k\xec\x1d\x9f\xef\xa6\xfb\x977\x99";
        Qh[24] = Qh[25][Qh[27]];
        Qh[26] = r15;
        Qh[33] = 1549328155345;
        Qh[27] = r16;
        Qh[28] = Qh[27](Qh[29], Qh[30]);
        Qh[25] = Qh[26][Qh[28]];
        Qh[30] = "\x0e\x00";
        Qh[27] = r15;
        Qh[28] = r16;
        Qh[31] = 25731700600526;
        Qh[29] = Qh[28](Qh[30], Qh[31]);
        Qh[26] = Qh[27][Qh[29]];
        Qh[28] = r15;
        Qh[31] = "VJ\x17\x02\x0ci\x06v\xceRBf\xb97\xee>~Q}l\xc7'\xe5\xe0\x9b\xdb*\xe4\x90}\xc3Fh\xab\xc1\x13+\x05\x91{\x85h\t";
        Qh[29] = r16;
        Qh[30] = Qh[29](Qh[31], Qh[32]);
        Qh[32] = "\xfc\xa1";
        Qh[27] = Qh[28][Qh[30]];
        Qh[29] = r15;
        Qh[30] = r16;
        Qh[31] = Qh[30](Qh[32], Qh[33]);
        Qh[33] = "M\x8f\x0c\xa9\n,\xd0\xa5=\xd6W\xc2\x142\xe0X\xa7\xd9b\xcb/\xf5\x044f\xdfe\x88\x8b\x9dK\xfc\x88S\r\xc0\xf3\xd0\xdd\x0f;\x80\xb6";
        Qh[28] = Qh[29][Qh[31]];
        Qh[30] = r15;
        Qh[31] = r16;
        Qh[32] = Qh[31](Qh[33], Qh[34]);
        Qh[29] = Qh[30][Qh[32]];
        Qh[31] = r15;
        Qh[32] = r16;
        Qh[34] = "U\xb9";
        Qh[33] = Qh[32](Qh[34], Qh[35]);
        Qh[30] = Qh[31][Qh[33]];
        Qh[35] = "\x8e8-\xc3\xfb\xd9Xe\xdf\xf5\xdd\xa5U\x85a\x8fM\x84\xebf$\xc11^\xdd\x926\xf1\t\x98\x0f\xbeiwHh\xc1\xf8\x99\x1bUK2";
        Qh[32] = r15;
        Qh[33] = r16;
        Qh[34] = Qh[33](Qh[35], Qh[36]);
        Qh[31] = Qh[32][Qh[34]];
        Qh[19] = {
            [Qh[20]] = Qh[21],
            [Qh[22]] = Qh[23],
            [Qh[24]] = Qh[25],
            [Qh[26]] = Qh[27],
            [Qh[28]] = Qh[29],
            [Qh[30]] = Qh[31]
        };
        Qh[25] = 24350581632075;
        Qh[32] = 683743166782;
        Qh[28] = 12711465047839;
        Qh[26] = "\xdb\xa4";
        Qh[27] = 28166597129020;
        Qh[21] = r15;
        Qh[22] = r16;
        Qh[24] = "\x7fQ\xe3`";
        Qh[23] = Qh[22](Qh[24], Qh[25]);
        Qh[20] = Qh[21][Qh[23]];
        Qh[23] = r15;
        Qh[24] = r16;
        Qh[25] = Qh[24](Qh[26], Qh[27]);
        Qh[22] = Qh[23][Qh[25]];
        Qh[27] = "\xc1\x97\x90\x06\x9b\x87\xb4\xc6e\xfe\xd5)\nT\xbc8r\x9e\xef\x85\xf8X\xab\x10";
        Qh[24] = r15;
        Qh[25] = r16;
        Qh[26] = Qh[25](Qh[27], Qh[28]);
        Qh[23] = Qh[24][Qh[26]];
        Qh[29] = 981251752392;
        Qh[28] = "\x80\x81";
        Qh[33] = 28412736893870;
        Qh[25] = r15;
        Qh[35] = 34642989612803;
        Qh[26] = r16;
        Qh[27] = Qh[26](Qh[28], Qh[29]);
        Qh[29] = "<x-\xac/\x02ENDI1>\x00\x8e\x13q\x1f 5\xa0\x03Q\x01\xce";
        Qh[34] = 18499419742630;
        Qh[24] = Qh[25][Qh[27]];
        Qh[26] = r15;
        Qh[31] = 24121694055392;
        Qh[27] = r16;
        Qh[30] = 31925145745938;
        Qh[28] = Qh[27](Qh[29], Qh[30]);
        Qh[30] = "\t\xd0";
        Qh[25] = Qh[26][Qh[28]];
        Qh[27] = r15;
        Qh[28] = r16;
        Qh[36] = 16800978361999;
        Qh[29] = Qh[28](Qh[30], Qh[31]);
        Qh[31] = "\xb4\xc0[\x11\x8e\xdc\xe9@\xafI\x97\xecAx%r\\\xff< \xa1\xdd_\xc3";
        Qh[26] = Qh[27][Qh[29]];
        Qh[28] = r15;
        Qh[29] = r16;
        Qh[30] = Qh[29](Qh[31], Qh[32]);
        Qh[27] = Qh[28][Qh[30]];
        Qh[29] = r15;
        Qh[32] = "\xf1\x9a";
        Qh[30] = r16;
        Qh[31] = Qh[30](Qh[32], Qh[33]);
        Qh[28] = Qh[29][Qh[31]];
        Qh[58] = 6989761203382;
        Qh[33] = "U\xca\xb9\xb1\x98\xf0\x9f\xcc8\x8a\x04Z\xd1\x1eAAj\xdc$\x0c\xfc\xf8\xdf\xde";
        Qh[30] = r15;
        Qh[31] = r16;
        Qh[32] = Qh[31](Qh[33], Qh[34]);
        Qh[34] = "}'";
        Qh[29] = Qh[30][Qh[32]];
        Qh[31] = r15;
        Qh[32] = r16;
        Qh[33] = Qh[32](Qh[34], Qh[35]);
        Qh[30] = Qh[31][Qh[33]];
        Qh[32] = r15;
        Qh[35] = "Fj\x8f\x89\xd9b$\xb9ub\xca\x94G\\P\x1b\x87\xe1\xd9\xce\xd2hHG";
        Qh[33] = r16;
        Qh[34] = Qh[33](Qh[35], Qh[36]);
        Qh[31] = Qh[32][Qh[34]];
        Qh[33] = r15;
        Qh[34] = r16;
        Qh[36] = "\\K";
        Qh[35] = Qh[34](Qh[36], Qh[37]);
        Qh[32] = Qh[33][Qh[35]];
        Qh[37] = "\xe8\xae\x1a\x12\xc4\xa6mg\x13\xcep\x19h\x0bS\xd3\x8aNF\xf6I\t\xd1\xa3";
        Qh[34] = r15;
        Qh[35] = r16;
        Qh[36] = Qh[35](Qh[37], Qh[38]);
        Qh[37] = 5439197891044;
        Qh[33] = Qh[34][Qh[36]];
        Qh[21] = {
            [Qh[22]] = Qh[23],
            [Qh[24]] = Qh[25],
            [Qh[26]] = Qh[27],
            [Qh[28]] = Qh[29],
            [Qh[30]] = Qh[31],
            [Qh[32]] = Qh[33]
        };
        Qh[27] = 18271537324348;
        Qh[36] = 33619645627687;
        Qh[26] = "\x81\x87i\n\xfb\xf8";
        Qh[35] = 29335342462300;
        Qh[23] = r15;
        Qh[24] = r16;
        Qh[25] = Qh[24](Qh[26], Qh[27]);
        Qh[33] = 2534932677788;
        Qh[22] = Qh[23][Qh[25]];
        Qh[28] = "\xebU";
        Qh[25] = r15;
        Qh[29] = 17841226162291;
        Qh[26] = r16;
        Qh[32] = 8729217798112;
        Qh[27] = Qh[26](Qh[28], Qh[29]);
        Qh[29] = "xS\xd4\xe2_UR\xeb\xc4\xa1O\xdb\xfd?\x13\xdfAfx\xef\xfe}";
        Qh[24] = Qh[25][Qh[27]];
        Qh[26] = r15;
        Qh[31] = 7230560210214;
        Qh[34] = 24720555732215;
        Qh[30] = 30796001982468;
        Qh[27] = r16;
        Qh[28] = Qh[27](Qh[29], Qh[30]);
        Qh[25] = Qh[26][Qh[28]];
        Qh[30] = "b\x07";
        Qh[27] = r15;
        Qh[28] = r16;
        Qh[29] = Qh[28](Qh[30], Qh[31]);
        Qh[31] = "\x04\xc9C\xa8Y\xa6\xbf\x97\xbb\x96\x94\xd4\xb29\x87\x08)\x88\xdcwl\x98";
        Qh[26] = Qh[27][Qh[29]];
        Qh[38] = 29949373412986;
        Qh[28] = r15;
        Qh[29] = r16;
        Qh[30] = Qh[29](Qh[31], Qh[32]);
        Qh[27] = Qh[28][Qh[30]];
        Qh[29] = r15;
        Qh[32] = "!W";
        Qh[30] = r16;
        Qh[31] = Qh[30](Qh[32], Qh[33]);
        Qh[28] = Qh[29][Qh[31]];
        Qh[33] = "\xa38\xc8#\xa3{\xdf}\x99\x15\xe7b\xe6W\x1c2\xa2,v\xd9\x18J";
        Qh[30] = r15;
        Qh[31] = r16;
        Qh[32] = Qh[31](Qh[33], Qh[34]);
        Qh[29] = Qh[30][Qh[32]];
        Qh[31] = r15;
        Qh[34] = "%S";
        Qh[32] = r16;
        Qh[33] = Qh[32](Qh[34], Qh[35]);
        Qh[30] = Qh[31][Qh[33]];
        Qh[32] = r15;
        Qh[33] = r16;
        Qh[35] = "\x06 \xf8\x1e1v\xad\xb11\xf1\x87s\x1c\xd0\x0f\xe8v]\x1f\x8cH\xe8";
        Qh[34] = Qh[33](Qh[35], Qh[36]);
        Qh[31] = Qh[32][Qh[34]];
        Qh[33] = r15;
        Qh[34] = r16;
        Qh[36] = "\x90b";
        Qh[35] = Qh[34](Qh[36], Qh[37]);
        Qh[32] = Qh[33][Qh[35]];
        Qh[34] = r15;
        Qh[35] = r16;
        Qh[37] = "\xaf\xfe\x93v\xc8!\x84\x10\x1aQ\x01\xd1\xe3\tI\x8e\xd6B\xa0\xed\xe4\x9f";
        Qh[36] = Qh[35](Qh[37], Qh[38]);
        Qh[33] = Qh[34][Qh[36]];
        Qh[35] = r15;
        Qh[38] = "\xc9\x11";
        Qh[36] = r16;
        Qh[37] = Qh[36](Qh[38], Qh[39]);
        Qh[34] = Qh[35][Qh[37]];
        Qh[36] = r15;
        Qh[39] = "\x00\xce\xcd{i\xafL\x9a\x03\x8d\xfd\xe1\x99d\x0e\xb974_\xe2\x98\x80";
        Qh[37] = r16;
        Qh[38] = Qh[37](Qh[39], Qh[40]);
        Qh[35] = Qh[36][Qh[38]];
        Qh[23] = {
            [Qh[24]] = Qh[25],
            [Qh[26]] = Qh[27],
            [Qh[28]] = Qh[29],
            [Qh[30]] = Qh[31],
            [Qh[32]] = Qh[33],
            [Qh[34]] = Qh[35]
        };
        Qh[29] = 16596006379056;
        Qh[28] = "\xae=\xa9\xea\xba";
        Qh[25] = r15;
        Qh[26] = r16;
        Qh[27] = Qh[26](Qh[28], Qh[29]);
        Qh[32] = 33312740261016;
        Qh[24] = Qh[25][Qh[27]];
        Qh[40] = 6042572983037;
        Qh[27] = r15;
        Qh[30] = "D\xdb";
        Qh[37] = 17105251032861;
        Qh[28] = r16;
        Qh[31] = 18210087117087;
        Qh[33] = 14164896831940;
        Qh[36] = 7147121855744;
        Qh[34] = 4393785985022;
        Qh[29] = Qh[28](Qh[30], Qh[31]);
        Qh[26] = Qh[27][Qh[29]];
        Qh[31] = "\r]\x91\x08\xff\x8b\xe13\xe7\xeb\xddG\x9d\x8b\xff>\xb7\x9dc\xabF\xb3B\xdd\xd0,\xe5\xe9\xfb\x13\xb2\x15\xe0\x85\xc1CBD|\xa8\xbd";
        Qh[28] = r15;
        Qh[29] = r16;
        Qh[30] = Qh[29](Qh[31], Qh[32]);
        Qh[35] = 22478949787875;
        Qh[27] = Qh[28][Qh[30]];
        Qh[32] = "\x9a\xb7";
        Qh[29] = r15;
        Qh[30] = r16;
        Qh[44] = 30845586372635;
        Qh[31] = Qh[30](Qh[32], Qh[33]);
        Qh[28] = Qh[29][Qh[31]];
        Qh[33] = "\xe4_\x8b\x1a\x99\x1f\xda\x1e\xa4\x87\xa1%\xc6k\xdb\x98\xb2N\xd9\x0f6\n\x8b`b\xac\nv\xa4;Y/Ef2\xb3\xda\x1c\xf2A\x91";
        Qh[30] = r15;
        Qh[31] = r16;
        Qh[38] = 23460201540268;
        Qh[32] = Qh[31](Qh[33], Qh[34]);
        Qh[34] = "j\xef";
        Qh[29] = Qh[30][Qh[32]];
        Qh[31] = r15;
        Qh[32] = r16;
        Qh[33] = Qh[32](Qh[34], Qh[35]);
        Qh[30] = Qh[31][Qh[33]];
        Qh[32] = r15;
        Qh[33] = r16;
        Qh[35] = "\x99\x1e\x9el\xb7\xcb\x02\x85\xbf\x8f\xed\x11\x8da~\x8e\xda\x9e\x9eLG?\x8de\xefs\xa2\x0f-\x1f`!\xe0\xfb\x8b\xf7\xd6\t\xa6\x12\xda";
        Qh[34] = Qh[33](Qh[35], Qh[36]);
        Qh[36] = "~m";
        Qh[31] = Qh[32][Qh[34]];
        Qh[33] = r15;
        Qh[34] = r16;
        Qh[35] = Qh[34](Qh[36], Qh[37]);
        Qh[37] = "\xf1M\xb4r`\xad\xa5\x9f\xef{8\x96\r\x9c\xa9l\xa3Ft\xe9\xd6)X\x8b*$-n\x0f\xb2q\xa8C\xb5\np$\xd3\xbfk\xcf";
        Qh[32] = Qh[33][Qh[35]];
        Qh[39] = 3887895496466;
        Qh[34] = r15;
        Qh[35] = r16;
        Qh[36] = Qh[35](Qh[37], Qh[38]);
        Qh[38] = "b\x86";
        Qh[33] = Qh[34][Qh[36]];
        Qh[35] = r15;
        Qh[36] = r16;
        Qh[37] = Qh[36](Qh[38], Qh[39]);
        Qh[34] = Qh[35][Qh[37]];
        Qh[36] = r15;
        Qh[39] = "[\x08l\xd9\xcd\xf6\xb1\xe8\xc9jTt^\x04\xfc\xfe0(\xad7-\x89>\xf9)-\xbcQaN=\x9f\xc8 \x97\x1b\xb83\xcf\xe2Y";
        Qh[37] = r16;
        Qh[38] = Qh[37](Qh[39], Qh[40]);
        Qh[35] = Qh[36][Qh[38]];
        Qh[37] = r15;
        Qh[38] = r16;
        Qh[40] = "\x87\xa4";
        Qh[39] = Qh[38](Qh[40], Qh[41]);
        Qh[36] = Qh[37][Qh[39]];
        Qh[38] = r15;
        Qh[41] = "\x15\x98O?\x1b\xc1\xc8\xe0\x08\xffw\xae+C\xf2q~/\xee0\x00\xc0,\xcd\x06\x19\"$\x00\x83\xd1\xeat\xdb\xd6\x9f\xd4\xae9\xef\xab";
        Qh[39] = r16;
        Qh[40] = Qh[39](Qh[41], Qh[42]);
        Qh[37] = Qh[38][Qh[40]];
        Qh[38] = 27965398217438;
        Qh[25] = {
            [Qh[26]] = Qh[27],
            [Qh[28]] = Qh[29],
            [Qh[30]] = Qh[31],
            [Qh[32]] = Qh[33],
            [Qh[34]] = Qh[35],
            [Qh[36]] = Qh[37]
        };
        Qh[27] = r15;
        Qh[33] = 23602562231022;
        Qh[28] = r16;
        Qh[39] = 14651271879334;
        Qh[30] = "\xc4I\xee\x88\xd0m\xa9\xd6\x8bhAO\xa0\xf1";
        Qh[32] = "\xba\xc3";
        Qh[34] = 13917238663504;
        Qh[31] = 24541992725668;
        Qh[29] = Qh[28](Qh[30], Qh[31]);
        Qh[26] = Qh[27][Qh[29]];
        Qh[29] = r15;
        Qh[30] = r16;
        Qh[31] = Qh[30](Qh[32], Qh[33]);
        Qh[40] = 4234964092852;
        Qh[28] = Qh[29][Qh[31]];
        Qh[33] = "\x1f\xd3R\xf2\xa7\x861p\x03\xb7~\x0c\xf7\xb1#\x1ei?\x9f:\xce\xe3\xcc\xed\x0f\xd7\x90r7\xf8}=T\x94\x05,\x13";
        Qh[37] = 32188775987853;
        Qh[30] = r15;
        Qh[35] = 10124172038762;
        Qh[31] = r16;
        Qh[32] = Qh[31](Qh[33], Qh[34]);
        Qh[29] = Qh[30][Qh[32]];
        Qh[34] = "$\x85";
        Qh[31] = r15;
        Qh[32] = r16;
        Qh[33] = Qh[32](Qh[34], Qh[35]);
        Qh[41] = 1510243910335;
        Qh[36] = 19039642002082;
        Qh[30] = Qh[31][Qh[33]];
        Qh[35] = "\xfe8\x10/f7\xc8\xc9\x0b\xa0\xf57!N\x949\xbb\x97\xf8\xdf\xa2\x12|\xd8\xc3\x01\x8f\xff\xa4\x83,\x8e\xaa*>\x0ee";
        Qh[32] = r15;
        Qh[42] = 17186204573506;
        Qh[33] = r16;
        Qh[34] = Qh[33](Qh[35], Qh[36]);
        Qh[36] = "C\x86";
        Qh[31] = Qh[32][Qh[34]];
        Qh[33] = r15;
        Qh[34] = r16;
        Qh[35] = Qh[34](Qh[36], Qh[37]);
        Qh[32] = Qh[33][Qh[35]];
        Qh[34] = r15;
        Qh[37] = "E(\x00\xa2\x90G=Y\xc8\xfcX\x86\xed\xd7\x91|\xb1\xe4t\xa2\xb4UmGg\xc2\xf6\xaaz\xb6+-\x89\x914}\x1b";
        Qh[35] = r16;
        Qh[36] = Qh[35](Qh[37], Qh[38]);
        Qh[33] = Qh[34][Qh[36]];
        Qh[38] = "A\xa1";
        Qh[35] = r15;
        Qh[36] = r16;
        Qh[37] = Qh[36](Qh[38], Qh[39]);
        Qh[39] = " \xb1\x11\xa6Uva\x1cEj\xbe\xd6\tXr\x16\x1b\xb1\x80\x9bC\xf5\x08\xda\xc0\"5\xa6\t\xf1\xc3\xff\xe3e\x96j\xd5";
        Qh[34] = Qh[35][Qh[37]];
        Qh[36] = r15;
        Qh[37] = r16;
        Qh[38] = Qh[37](Qh[39], Qh[40]);
        Qh[35] = Qh[36][Qh[38]];
        Qh[40] = ")\x8c";
        Qh[37] = r15;
        Qh[38] = r16;
        Qh[39] = Qh[38](Qh[40], Qh[41]);
        Qh[36] = Qh[37][Qh[39]];
        Qh[38] = r15;
        Qh[39] = r16;
        Qh[41] = "\xec\x1b\xc4\xfac\xd2\xb6q\x078\xc1E=\xa9\x80\x04P\xf7\x17 \xe1Y~TKU\xe6\x15}0r\x05M\xc22V\x8c";
        Qh[40] = Qh[39](Qh[41], Qh[42]);
        Qh[37] = Qh[38][Qh[40]];
        Qh[42] = "\xa0\x95";
        Qh[39] = r15;
        Qh[40] = r16;
        Qh[41] = Qh[40](Qh[42], Qh[43]);
        Qh[38] = Qh[39][Qh[41]];
        Qh[40] = r15;
        Qh[41] = r16;
        Qh[43] = "\xbd\xa6\xea\xfb\xde\xc1\xb8X\x00\xefb\xe5\xe3j@1\x9c\x80u\x95\x169\xe3H>\xbc\x84\xb2,\x89\xb7w\xa5q+\x9d\xdb";
        Qh[42] = Qh[41](Qh[43], Qh[44]);
        Qh[39] = Qh[40][Qh[42]];
        Qh[27] = {
            [Qh[28]] = Qh[29],
            [Qh[30]] = Qh[31],
            [Qh[32]] = Qh[33],
            [Qh[34]] = Qh[35],
            [Qh[36]] = Qh[37],
            [Qh[38]] = Qh[39]
        };
        Qh[33] = 15621478095978;
        Qh[32] = "\xc7u\xbe\xc8+\x8a\xef\xf3G";
        Qh[29] = r15;
        Qh[30] = r16;
        Qh[31] = Qh[30](Qh[32], Qh[33]);
        Qh[28] = Qh[29][Qh[31]];
        Qh[35] = 34394717732496;
        Qh[34] = "\xdbs";
        Qh[37] = 32282237041336;
        Qh[36] = 25610587680405;
        Qh[31] = r15;
        Qh[32] = r16;
        Qh[33] = Qh[32](Qh[34], Qh[35]);
        Qh[30] = Qh[31][Qh[33]];
        Qh[32] = r15;
        Qh[33] = r16;
        Qh[43] = 19701738038230;
        Qh[44] = 15804189957311;
        Qh[35] = "\xed\xc0z\xa2=n\xea7\x10_\xb4\xf5\xfew\xaa\xd4\x15'\xb4}|H\xf1C\xa5U\x9c\xa1\x0bn\xce\xbdH\xc8JlI\xcb\xc9\x00\xb5";
        Qh[34] = Qh[33](Qh[35], Qh[36]);
        Qh[36] = "?\x0b";
        Qh[31] = Qh[32][Qh[34]];
        Qh[33] = r15;
        Qh[34] = r16;
        Qh[38] = 30381244118851;
        Qh[35] = Qh[34](Qh[36], Qh[37]);
        Qh[37] = "\x11\xf7#l,\xedW\x11\x16\xa3y)S\xa4\x13\xc2\xffR.\xaf\xdb4\x86\xfd\xac_\xc9<\\\xdc]\x9e\xf8o\xc4e\xd3\xe7\x99\xcf\xed";
        Qh[39] = 7022221970629;
        Qh[32] = Qh[33][Qh[35]];
        Qh[34] = r15;
        Qh[35] = r16;
        Qh[36] = Qh[35](Qh[37], Qh[38]);
        Qh[40] = 15307952053208;
        Qh[33] = Qh[34][Qh[36]];
        Qh[35] = r15;
        Qh[36] = r16;
        Qh[41] = 28509612274651;
        Qh[38] = "\xbb\xe3";
        Qh[45] = 28334240658314;
        Qh[37] = Qh[36](Qh[38], Qh[39]);
        Qh[34] = Qh[35][Qh[37]];
        Qh[36] = r15;
        Qh[39] = "\x8fI\xa8\xcb\xb1.\x0f!k\xf7\xf0\xb3t\xe6\xe9\xc4\xc8\x13t\x0c\xe4\xad\x0e\x16\x011\x07`\xdfW\x10\x8f*\x92Sm\xa8\x93+\xbb\xa9";
        Qh[37] = r16;
        Qh[38] = Qh[37](Qh[39], Qh[40]);
        Qh[40] = "\xbf\xd1";
        Qh[42] = 21187118802570;
        Qh[35] = Qh[36][Qh[38]];
        Qh[37] = r15;
        Qh[38] = r16;
        Qh[39] = Qh[38](Qh[40], Qh[41]);
        Qh[36] = Qh[37][Qh[39]];
        Qh[38] = r15;
        Qh[39] = r16;
        Qh[41] = "3>*c\xd7\\\xd1t8\xcaMd2I\x12\xb7\x9b\x05\x88\x9eB\xfd%)\xa7\xdc\xc0\x02 2\xbb\xe3\xa1`\x19\"\x92\xc3\x02\xee\x8b";
        Qh[40] = Qh[39](Qh[41], Qh[42]);
        Qh[37] = Qh[38][Qh[40]];
        Qh[39] = r15;
        Qh[40] = r16;
        Qh[42] = "\xebX";
        Qh[41] = Qh[40](Qh[42], Qh[43]);
        Qh[38] = Qh[39][Qh[41]];
        Qh[40] = r15;
        Qh[41] = r16;
        Qh[43] = "\xcc\xfdFv4\xef`\xf1\xd7\xc5\xf7X\xfb\x89^{\x86\x0eH,\xa7-\xf0\xeb\xeb\x8avdV\x1f\x95y`q\xadQ\xdb\xc1\xb4(K";
        Qh[42] = Qh[41](Qh[43], Qh[44]);
        Qh[44] = "\x89d";
        Qh[39] = Qh[40][Qh[42]];
        Qh[41] = r15;
        Qh[42] = r16;
        Qh[43] = Qh[42](Qh[44], Qh[45]);
        Qh[40] = Qh[41][Qh[43]];
        Qh[42] = r15;
        Qh[43] = r16;
        Qh[45] = "\xc5\x8fs\xf4\x17\x83\xcd\xdd\x81\xe1\x80\x9fB\xef\xd0k\x9a\x9cn\xcb|\x183\x13<6\xabZ\"\x80\xa3\xf7-\xff\x81^\xe0\xae\x89\xfe\xe7";
        Qh[44] = Qh[43](Qh[45], Qh[46]);
        Qh[41] = Qh[42][Qh[44]];
        Qh[29] = {
            [Qh[30]] = Qh[31],
            [Qh[32]] = Qh[33],
            [Qh[34]] = Qh[35],
            [Qh[36]] = Qh[37],
            [Qh[38]] = Qh[39],
            [Qh[40]] = Qh[41]
        };
        Qh[35] = 4080019408747;
        Qh[34] = "h\xe9\x86N\xbe\x1a\xd321\xcc";
        Qh[31] = r15;
        Qh[38] = 7665189948913;
        Qh[32] = r16;
        Qh[37] = 32222136154780;
        Qh[33] = Qh[32](Qh[34], Qh[35]);
        Qh[30] = Qh[31][Qh[33]];
        Qh[33] = r15;
        Qh[34] = r16;
        Qh[39] = 28223964132182;
        Qh[36] = "\x0e\xf9";
        Qh[35] = Qh[34](Qh[36], Qh[37]);
        Qh[32] = Qh[33][Qh[35]];
        Qh[34] = r15;
        Qh[40] = 29338396456285;
        Qh[35] = r16;
        Qh[37] = "\x0fS\x01i5x\x99\xc18\xba\\G\xc8e\xf5!\xf5P:\xb2X\xf5\x00kZ\x7fU\x034\xe5\xc3M\x12\xf0o\xc6\xe1\xe2\xefWC";
        Qh[36] = Qh[35](Qh[37], Qh[38]);
        Qh[43] = 8071263014574;
        Qh[33] = Qh[34][Qh[36]];
        Qh[35] = r15;
        Qh[38] = "\xe4v";
        Qh[36] = r16;
        Qh[37] = Qh[36](Qh[38], Qh[39]);
        Qh[34] = Qh[35][Qh[37]];
        Qh[41] = 32207182674581;
        Qh[39] = "?X\xe0\x07\x9a'\xa8\x1b\x1b9\xc1)\x17\xd9\xf0\xadZ\x86v\xa4j\xe0\x1b\x16\x1c\xb2Vw\xbe\xb3\xe6\xf7q\xbf\x80;\xd21Z)\xb4";
        Qh[36] = r15;
        Qh[37] = r16;
        Qh[42] = 16642154257989;
        Qh[38] = Qh[37](Qh[39], Qh[40]);
        Qh[45] = 497424171239;
        Qh[35] = Qh[36][Qh[38]];
        Qh[40] = "\xd7\xa6";
        Qh[46] = 5075666897211;
        Qh[44] = 7146982624512;
        Qh[37] = r15;
        Qh[38] = r16;
        Qh[39] = Qh[38](Qh[40], Qh[41]);
        Qh[36] = Qh[37][Qh[39]];
        Qh[38] = r15;
        Qh[39] = r16;
        Qh[41] = "\x07\xf1b\x8a\x7f\xc27\xa6s\xccw\xbe\x85\xd6\xe9<\xf6&\x9c3\xa7JPQ\xee\x19\xd0\xb6<\xfe\\)$\x8b\xce\x85\t\xd1lp\x11";
        Qh[40] = Qh[39](Qh[41], Qh[42]);
        Qh[37] = Qh[38][Qh[40]];
        Qh[39] = r15;
        Qh[42] = "_!";
        Qh[40] = r16;
        Qh[41] = Qh[40](Qh[42], Qh[43]);
        Qh[43] = "(\xd6\xed\xb4\x81^\xd4S\xef\x8cQ\x19\x85\xec\x04<Bf!\xc6_\xdd\xd8\xadB\xc0}\x8c\x11\x80l\x8a?\x90\xeb\xc9\x9c\x8e\xce\x1eN";
        Qh[38] = Qh[39][Qh[41]];
        Qh[40] = r15;
        Qh[41] = r16;
        Qh[42] = Qh[41](Qh[43], Qh[44]);
        Qh[39] = Qh[40][Qh[42]];
        Qh[44] = "`\x9b";
        Qh[41] = r15;
        Qh[42] = r16;
        Qh[43] = Qh[42](Qh[44], Qh[45]);
        Qh[40] = Qh[41][Qh[43]];
        Qh[42] = r15;
        Qh[43] = r16;
        Qh[45] = "\n\x00\n\xb8<\xc5\x051\x89'\x7f\x9d\t\xbf\xa2&\xb8;\xc0)9@Z I\xc6\xdeI\xe0rJ^\x9c\"K\xd4\xb4\xc7\x84\xb2\xcf";
        Qh[44] = Qh[43](Qh[45], Qh[46]);
        Qh[41] = Qh[42][Qh[44]];
        Qh[43] = r15;
        Qh[44] = r16;
        Qh[46] = "#\xa0";
        Qh[45] = Qh[44](Qh[46], Qh[47]);
        Qh[42] = Qh[43][Qh[45]];
        Qh[44] = r15;
        Qh[45] = r16;
        Qh[47] = "\xad\x06|\x07m\xe8G\xb7\xfc\x0c:\xa1\xbd\x93i\xf1\x06t\x07V\xd7!j$\x9f\xd3\x8b\xc6\xdc\xaf\xd92\xd7\x13\xfcRD}\xa8\x03\x1d";
        Qh[46] = Qh[45](Qh[47], Qh[48]);
        Qh[45] = 22710054611279;
        Qh[43] = Qh[44][Qh[46]];
        Qh[31] = {
            [Qh[32]] = Qh[33],
            [Qh[34]] = Qh[35],
            [Qh[36]] = Qh[37],
            [Qh[38]] = Qh[39],
            [Qh[40]] = Qh[41],
            [Qh[42]] = Qh[43]
        };
        Qh[33] = r15;
        Qh[36] = "\xcd\xae\xef\x88A@\xccdj\x92\xa5\xfb\xc7";
        Qh[34] = r16;
        Qh[43] = 12772006614843;
        Qh[37] = 9310630990063;
        Qh[35] = Qh[34](Qh[36], Qh[37]);
        Qh[40] = 32334900624081;
        Qh[39] = 1438252647069;
        Qh[44] = 2292124353579;
        Qh[42] = 32283839036089;
        Qh[32] = Qh[33][Qh[35]];
        Qh[35] = r15;
        Qh[38] = "\xac\xc2";
        Qh[36] = r16;
        Qh[46] = 9869871567348;
        Qh[37] = Qh[36](Qh[38], Qh[39]);
        Qh[34] = Qh[35][Qh[37]];
        Qh[41] = 3081778726299;
        Qh[39] = "\xf85\xb5\x81\xa6\xe2\x80\xa4[\xd1\xcaJ6\x9ak\x97\tAl\xdf\x96&";
        Qh[36] = r15;
        Qh[37] = r16;
        Qh[38] = Qh[37](Qh[39], Qh[40]);
        Qh[35] = Qh[36][Qh[38]];
        Qh[37] = r15;
        Qh[40] = "V\xcd";
        Qh[38] = r16;
        Qh[39] = Qh[38](Qh[40], Qh[41]);
        Qh[41] = "\x84\x85\xf6\"k\xdb\xcf\x86\\2\xa541g\xfb\x83\xc1\xc0T\x1a\x011";
        Qh[36] = Qh[37][Qh[39]];
        Qh[38] = r15;
        Qh[39] = r16;
        Qh[40] = Qh[39](Qh[41], Qh[42]);
        Qh[37] = Qh[38][Qh[40]];
        Qh[39] = r15;
        Qh[42] = "kL";
        Qh[40] = r16;
        Qh[41] = Qh[40](Qh[42], Qh[43]);
        Qh[38] = Qh[39][Qh[41]];
        Qh[43] = "\x1c\xc8:\xf5e\xd8\xb5\x9e\xd1\nx\xb2\xb3J\x1fc\x08\xd9\xc3\xca\x0c\xae";
        Qh[40] = r15;
        Qh[41] = r16;
        Qh[42] = Qh[41](Qh[43], Qh[44]);
        Qh[39] = Qh[40][Qh[42]];
        Qh[44] = "w\xee";
        Qh[41] = r15;
        Qh[42] = r16;
        Qh[43] = Qh[42](Qh[44], Qh[45]);
        Qh[40] = Qh[41][Qh[43]];
        Qh[45] = "8O.\x13\xce\xd9\xd9~\xcft\x80x\xc5\xb2\x03\xfc\x97\xd2\xe1\xf6\xbb\x18";
        Qh[42] = r15;
        Qh[43] = r16;
        Qh[44] = Qh[43](Qh[45], Qh[46]);
        Qh[41] = Qh[42][Qh[44]];
        Qh[43] = r15;
        Qh[48] = 29732276581909;
        Qh[44] = r16;
        Qh[47] = 32673368472430;
        Qh[46] = "\x17\xd0";
        Qh[45] = Qh[44](Qh[46], Qh[47]);
        Qh[42] = Qh[43][Qh[45]];
        Qh[47] = "\xe4\xedM\x83\xde2\xc4\xe1\x04(MP\x16M!\xbb\x8f\x03\xddX7\x0e";
        Qh[44] = r15;
        Qh[45] = r16;
        Qh[46] = Qh[45](Qh[47], Qh[48]);
        Qh[43] = Qh[44][Qh[46]];
        Qh[45] = r15;
        Qh[46] = r16;
        Qh[48] = "\x97\x0b";
        Qh[47] = Qh[46](Qh[48], Qh[49]);
        Qh[49] = "\xdf\xa5Z\x90\xd6X:\x17I\xbb\xcc\xd1\xc3\xf6\x96\x8a5\x0e\xe9\x9c\xc3\x14";
        Qh[44] = Qh[45][Qh[47]];
        Qh[46] = r15;
        Qh[47] = r16;
        Qh[48] = Qh[47](Qh[49], Qh[50]);
        Qh[47] = 18982996501127;
        Qh[45] = Qh[46][Qh[48]];
        Qh[33] = {
            [Qh[34]] = Qh[35],
            [Qh[36]] = Qh[37],
            [Qh[38]] = Qh[39],
            [Qh[40]] = Qh[41],
            [Qh[42]] = Qh[43],
            [Qh[44]] = Qh[45]
        };
        Qh[39] = 15735023279263;
        Qh[35] = r15;
        Qh[36] = r16;
        Qh[38] = "\x91\x96mj\x16\xdc!H\xcb\"";
        Qh[40] = "\xe7\x11";
        Qh[37] = Qh[36](Qh[38], Qh[39]);
        Qh[34] = Qh[35][Qh[37]];
        Qh[45] = 10698445919093;
        Qh[41] = 9695189569954;
        Qh[37] = r15;
        Qh[38] = r16;
        Qh[46] = 5922655898309;
        Qh[39] = Qh[38](Qh[40], Qh[41]);
        Qh[41] = "R\xd7>\xb7*j1\x05\xd6\xc0C\x1d*\xb4\xb9bD\xd6N$\xc4\x9c+}\xc5\x94\xa2\xf71(\xbc\x1d\x91\xa6\x13jU!L\x00";
        Qh[42] = 6618426510345;
        Qh[36] = Qh[37][Qh[39]];
        Qh[38] = r15;
        Qh[48] = 3738037946060;
        Qh[43] = 8884891832361;
        Qh[39] = r16;
        Qh[40] = Qh[39](Qh[41], Qh[42]);
        Qh[37] = Qh[38][Qh[40]];
        Qh[39] = r15;
        Qh[42] = "\x13O";
        Qh[40] = r16;
        Qh[44] = 11317806535830;
        Qh[41] = Qh[40](Qh[42], Qh[43]);
        Qh[38] = Qh[39][Qh[41]];
        Qh[43] = "O \x87!\xe8\xfac\x14\x0c%w\x1cp_\x10\x12\xd3 \x00\x9b\xa2\xca\x0b\x1e\x11\xd4\xec\x80\xa3ya\xc2\xc8{SV3b\x8f?";
        Qh[40] = r15;
        Qh[41] = r16;
        Qh[42] = Qh[41](Qh[43], Qh[44]);
        Qh[39] = Qh[40][Qh[42]];
        Qh[44] = "7t";
        Qh[41] = r15;
        Qh[42] = r16;
        Qh[43] = Qh[42](Qh[44], Qh[45]);
        Qh[45] = "\x08\xe0\xa8\xf2\xf4\xf2P\x89+\xf79@mgi\x95\xd7J\x8f\xcc<<z-\xf5\xec\x16\xfcu\x04\xff\xdb^\xddm\xa8/R\\#";
        Qh[40] = Qh[41][Qh[43]];
        Qh[42] = r15;
        Qh[43] = r16;
        Qh[44] = Qh[43](Qh[45], Qh[46]);
        Qh[46] = "\xf5\x08";
        Qh[41] = Qh[42][Qh[44]];
        Qh[50] = 16005807070493;
        Qh[43] = r15;
        Qh[44] = r16;
        Qh[45] = Qh[44](Qh[46], Qh[47]);
        Qh[42] = Qh[43][Qh[45]];
        Qh[47] = "\xeaz\t\xbfar\xbaZ\xb2\x0b\x909\xf5&o#\x90&\xa6D$\x02\xf2\xad\xee\x1a\xa2\xf3\x7f\x8d\xee\xad\x81\xa9lVQ\x7f\xeb\xf2";
        Qh[44] = r15;
        Qh[45] = r16;
        Qh[46] = Qh[45](Qh[47], Qh[48]);
        Qh[43] = Qh[44][Qh[46]];
        Qh[45] = r15;
        Qh[49] = 76680249379;
        Qh[48] = "=\x1c";
        Qh[46] = r16;
        Qh[47] = Qh[46](Qh[48], Qh[49]);
        Qh[44] = Qh[45][Qh[47]];
        Qh[46] = r15;
        Qh[47] = r16;
        Qh[49] = ">Ju\xc6\x9e\xdd:\xe4\x90o\x0b\\\x9cb,\xfe\xfb71$lX\x9a\x9d\x8a\x1f*\xf8\x9d<<>q\xa8\xa7 s\xed\x9f\x12";
        Qh[48] = Qh[47](Qh[49], Qh[50]);
        Qh[45] = Qh[46][Qh[48]];
        Qh[47] = r15;
        Qh[48] = r16;
        Qh[50] = "\xe7\xbb";
        Qh[49] = Qh[48](Qh[50], Qh[51]);
        Qh[46] = Qh[47][Qh[49]];
        Qh[48] = r15;
        Qh[49] = r16;
        Qh[51] = "\xafI\x05\x05\xb4\xad!\xf4;\x10i\xb5\xd3?\xbb\x19S\xee\x87\xff\xdb\xe8\xf5m\xd6\x15B+\x84\x8e\xfd\xe5\xbd\xc6\xbf\xe6<\x1c\x01}";
        Qh[50] = Qh[49](Qh[51], Qh[52]);
        Qh[47] = Qh[48][Qh[50]];
        Qh[35] = {
            [Qh[36]] = Qh[37],
            [Qh[38]] = Qh[39],
            [Qh[40]] = Qh[41],
            [Qh[42]] = Qh[43],
            [Qh[44]] = Qh[45],
            [Qh[46]] = Qh[47]
        };
        Qh[43] = 20877616391673;
        Qh[40] = "e\xb3@\xc8\xebO";
        Qh[44] = 13223610177549;
        Qh[37] = r15;
        Qh[41] = 23152789695005;
        Qh[38] = r16;
        Qh[42] = "y\x0f";
        Qh[39] = Qh[38](Qh[40], Qh[41]);
        Qh[36] = Qh[37][Qh[39]];
        Qh[39] = r15;
        Qh[45] = 23080798431739;
        Qh[40] = r16;
        Qh[41] = Qh[40](Qh[42], Qh[43]);
        Qh[38] = Qh[39][Qh[41]];
        Qh[46] = 841940337032;
        Qh[43] = "\x06\xe4n\n\x8db7\xb0\x08;y7\xf8\xad\xcd\xa9\xbc&\x0efP\xd6\x1e\x0c";
        Qh[40] = r15;
        Qh[47] = 22534241183997;
        Qh[41] = r16;
        Qh[50] = 25616019910296;
        Qh[42] = Qh[41](Qh[43], Qh[44]);
        Qh[44] = "Vf";
        Qh[39] = Qh[40][Qh[42]];
        Qh[41] = r15;
        Qh[42] = r16;
        Qh[43] = Qh[42](Qh[44], Qh[45]);
        Qh[40] = Qh[41][Qh[43]];
        Qh[42] = r15;
        Qh[45] = "#$F\xbb\x14\x03\x13+\xfcU%\xa4<\xc7\x86\xe0@\xe7\x88\xd5\xb8\xfa;\x01";
        Qh[43] = r16;
        Qh[44] = Qh[43](Qh[45], Qh[46]);
        Qh[41] = Qh[42][Qh[44]];
        Qh[46] = "\x82R";
        Qh[48] = 24519051095193;
        Qh[49] = 33176840977497;
        Qh[43] = r15;
        Qh[51] = 21618518026066;
        Qh[44] = r16;
        Qh[45] = Qh[44](Qh[46], Qh[47]);
        Qh[42] = Qh[43][Qh[45]];
        Qh[47] = "y\xa8\x7f\x8b\x1a\xb9\x91L\xe3\xbffU\xe59\x8b\xf3b7\xce\x0f\xa2\x17F!";
        Qh[44] = r15;
        Qh[45] = r16;
        Qh[46] = Qh[45](Qh[47], Qh[48]);
        Qh[43] = Qh[44][Qh[46]];
        Qh[48] = "\x14\x98";
        Qh[45] = r15;
        Qh[46] = r16;
        Qh[47] = Qh[46](Qh[48], Qh[49]);
        Qh[44] = Qh[45][Qh[47]];
        Qh[46] = r15;
        Qh[49] = "_)\xba\xd2\x07\x11*|g\xf3>\x8b]\x11h`Z\x8ca\x92\x020\xa8\xd2";
        Qh[52] = 10764475487124;
        Qh[47] = r16;
        Qh[48] = Qh[47](Qh[49], Qh[50]);
        Qh[45] = Qh[46][Qh[48]];
        Qh[47] = r15;
        Qh[50] = "'\xf4";
        Qh[48] = r16;
        Qh[49] = Qh[48](Qh[50], Qh[51]);
        Qh[46] = Qh[47][Qh[49]];
        Qh[51] = "R\xa2\xa7\x1c\xb3o\r\xb3\xc4\xe4$\xf2m\xd2~\xbc\xbf\xc2\xe7\xa8)\x9e\x19\x9c";
        Qh[48] = r15;
        Qh[49] = r16;
        Qh[50] = Qh[49](Qh[51], Qh[52]);
        Qh[47] = Qh[48][Qh[50]];
        Qh[52] = "e\xcc";
        Qh[49] = r15;
        Qh[50] = r16;
        Qh[51] = Qh[50](Qh[52], Qh[53]);
        Qh[48] = Qh[49][Qh[51]];
        Qh[53] = "`\xa7]\x95\x14K\xec\x84\x1f\x1d\xf9BA|\xb5f}5\xb6\xab\xb7\x95\x92\\";
        Qh[50] = r15;
        Qh[51] = r16;
        Qh[52] = Qh[51](Qh[53], Qh[54]);
        Qh[49] = Qh[50][Qh[52]];
        Qh[37] = {
            [Qh[38]] = Qh[39],
            [Qh[40]] = Qh[41],
            [Qh[42]] = Qh[43],
            [Qh[44]] = Qh[45],
            [Qh[46]] = Qh[47],
            [Qh[48]] = Qh[49]
        };
        Qh[43] = 20634347054472;
        Qh[46] = 3692105025207;
        Qh[42] = "X\xbc\x11\x1a\x80\xb4";
        Qh[52] = 28312020153215;
        Qh[44] = "F\x1b";
        Qh[39] = r15;
        Qh[40] = r16;
        Qh[41] = Qh[40](Qh[42], Qh[43]);
        Qh[38] = Qh[39][Qh[41]];
        Qh[45] = 25397140631090;
        Qh[41] = r15;
        Qh[42] = r16;
        Qh[43] = Qh[42](Qh[44], Qh[45]);
        Qh[51] = 22829803710854;
        Qh[40] = Qh[41][Qh[43]];
        Qh[42] = r15;
        Qh[43] = r16;
        Qh[45] = "\xb6\xb3\x13\xdd0j*P2c\xaa\xb4t\xbf\xb5A[\x04|\x06\x97\xa6|\xfe";
        Qh[44] = Qh[43](Qh[45], Qh[46]);
        Qh[46] = "}\xeb";
        Qh[41] = Qh[42][Qh[44]];
        Qh[47] = 10627798586196;
        Qh[43] = r15;
        Qh[44] = r16;
        Qh[45] = Qh[44](Qh[46], Qh[47]);
        Qh[42] = Qh[43][Qh[45]];
        Qh[47] = "\xc0\x00l\xae\xa28\xd7?\xbf\x0f$\xa2:\x92\xdc*\xff]\x98?\xe3\x1a\xed\x8e";
        Qh[44] = r15;
        Qh[49] = 19427128304470;
        Qh[48] = 16211377184125;
        Qh[50] = 20322988156151;
        Qh[45] = r16;
        Qh[46] = Qh[45](Qh[47], Qh[48]);
        Qh[43] = Qh[44][Qh[46]];
        Qh[45] = r15;
        Qh[54] = 33528249629948;
        Qh[46] = r16;
        Qh[48] = "jk";
        Qh[47] = Qh[46](Qh[48], Qh[49]);
        Qh[44] = Qh[45][Qh[47]];
        Qh[49] = "^i\x91\x12DUQ\x91D\xd6\xd3I\x1b\tly^\x89\xf2\x88IR\xf3\x81";
        Qh[53] = 31640794691981;
        Qh[46] = r15;
        Qh[47] = r16;
        Qh[48] = Qh[47](Qh[49], Qh[50]);
        Qh[50] = "\x18\x94";
        Qh[45] = Qh[46][Qh[48]];
        Qh[47] = r15;
        Qh[48] = r16;
        Qh[49] = Qh[48](Qh[50], Qh[51]);
        Qh[46] = Qh[47][Qh[49]];
        Qh[48] = r15;
        Qh[49] = r16;
        Qh[51] = "\x9b8\x14\x05W\xc5`\xdc\xd30\xd0\xb0\xb9{\x8a\xf2\x7f\xc0\xba\xd8k\xb3j-";
        Qh[50] = Qh[49](Qh[51], Qh[52]);
        Qh[47] = Qh[48][Qh[50]];
        Qh[52] = "/u";
        Qh[49] = r15;
        Qh[50] = r16;
        Qh[51] = Qh[50](Qh[52], Qh[53]);
        Qh[53] = "jJ\x90\x7f`J2\xd6\x93,Kb=>\xd5=\xe6\xab\xee\xfd\x11\xb63\xc1";
        Qh[48] = Qh[49][Qh[51]];
        Qh[50] = r15;
        Qh[51] = r16;
        Qh[52] = Qh[51](Qh[53], Qh[54]);
        Qh[54] = "h\x02";
        Qh[49] = Qh[50][Qh[52]];
        Qh[51] = r15;
        Qh[52] = r16;
        Qh[53] = Qh[52](Qh[54], Qh[55]);
        Qh[55] = "^\xed\xe91!W]\x1a\xff\xef\xa1N\xba\xf4\xc8+\xb7M\x8d{\xbf9t\x98";
        Qh[50] = Qh[51][Qh[53]];
        Qh[52] = r15;
        Qh[53] = r16;
        Qh[54] = Qh[53](Qh[55], Qh[56]);
        Qh[51] = Qh[52][Qh[54]];
        Qh[39] = {
            [Qh[40]] = Qh[41],
            [Qh[42]] = Qh[43],
            [Qh[44]] = Qh[45],
            [Qh[46]] = Qh[47],
            [Qh[48]] = Qh[49],
            [Qh[50]] = Qh[51]
        };
        Qh[45] = 2081915487177;
        Qh[41] = r15;
        Qh[47] = 34311356300905;
        Qh[44] = "\xacs)\xe8\x82\xb5\x96Tj";
        Qh[42] = r16;
        Qh[43] = Qh[42](Qh[44], Qh[45]);
        Qh[49] = 22462107707611;
        Qh[40] = Qh[41][Qh[43]];
        Qh[43] = r15;
        Qh[53] = 20498537669961;
        Qh[48] = 31445226174770;
        Qh[44] = r16;
        Qh[46] = "\xe8$";
        Qh[45] = Qh[44](Qh[46], Qh[47]);
        Qh[47] = "\x02\xad$\xee\xdbr\xdc\x8e\xdf_\x0b\x8a\xfbZ\x8aB\xcdA\x16\x18e\xdc\xcb";
        Qh[42] = Qh[43][Qh[45]];
        Qh[52] = 8155351994069;
        Qh[44] = r15;
        Qh[45] = r16;
        Qh[46] = Qh[45](Qh[47], Qh[48]);
        Qh[43] = Qh[44][Qh[46]];
        Qh[45] = r15;
        Qh[46] = r16;
        Qh[48] = "\x8c\x93";
        Qh[47] = Qh[46](Qh[48], Qh[49]);
        Qh[44] = Qh[45][Qh[47]];
        Qh[49] = "\x9a\xd4J\xb96L\xab\xb3KD\xbe\xd5\xd9Y\x94\xbfW\xc9\xd4\t'\xdc\x9b\x06\xb3_)@\xdc\xc5o\x1a\x8a\xa40\x8d{\xedgt8\xa0";
        Qh[46] = r15;
        Qh[55] = 8997292331101;
        Qh[47] = r16;
        Qh[50] = 7274927476027;
        Qh[48] = Qh[47](Qh[49], Qh[50]);
        Qh[50] = "J\xb7";
        Qh[51] = 19413643764560;
        Qh[45] = Qh[46][Qh[48]];
        Qh[47] = r15;
        Qh[48] = r16;
        Qh[49] = Qh[48](Qh[50], Qh[51]);
        Qh[51] = "\xe3&\xdck\xad\"\"2\x95WL\x03\x98\xf9\xfa\xf44\xb0\xcdG\xf5\x1aa\x8au@\xa8\xc2\xdf\x9a\x96\x1dG\x190{[/\xde\xed]\x9e";
        Qh[46] = Qh[47][Qh[49]];
        Qh[48] = r15;
        Qh[54] = 7310070107468;
        Qh[49] = r16;
        Qh[50] = Qh[49](Qh[51], Qh[52]);
        Qh[47] = Qh[48][Qh[50]];
        Qh[49] = r15;
        Qh[52] = "4?";
        Qh[50] = r16;
        Qh[51] = Qh[50](Qh[52], Qh[53]);
        Qh[53] = "rDx\xf5s$\xe4\xd3\x91n\x0b\xeb\xc9\x16-\xbd\x96'K\xb6\xf6s\xfb)\xcb\xf20\x07\xbc\x85\xf9\x89k\x0b\x8e\xa4R8\xfba\xcf\x1f";
        Qh[56] = 7848406748742;
        Qh[48] = Qh[49][Qh[51]];
        Qh[50] = r15;
        Qh[51] = r16;
        Qh[52] = Qh[51](Qh[53], Qh[54]);
        Qh[49] = Qh[50][Qh[52]];
        Qh[51] = r15;
        Qh[52] = r16;
        Qh[54] = "\xc1\xbb";
        Qh[53] = Qh[52](Qh[54], Qh[55]);
        Qh[55] = "\xf5\xfeu\xa6\x97\xed\x16\xc6w]\xa0\xe1\x874\x1e\xe3\xbe\x7f\xdc.\x01\xcb\x1dkM:.\xb4\rM *z\x15DGmR\xc4E\xfe\xe2";
        Qh[50] = Qh[51][Qh[53]];
        Qh[52] = r15;
        Qh[53] = r16;
        Qh[54] = Qh[53](Qh[55], Qh[56]);
        Qh[51] = Qh[52][Qh[54]];
        Qh[56] = "\n\xbe";
        Qh[53] = r15;
        Qh[54] = r16;
        Qh[55] = Qh[54](Qh[56], Qh[57]);
        Qh[52] = Qh[53][Qh[55]];
        Qh[57] = "k`\xb9, :\x90\xbam\x0bl\xe3\xb0\x0e]\xcf\xff@\xcf\xd9\x19S\xfe7\xcf\xd9+\xc9\x97` \xa2`\xef\x088)\xb2\xf2\xf1\xfc\xdb";
        Qh[54] = r15;
        Qh[55] = r16;
        Qh[56] = Qh[55](Qh[57], Qh[58]);
        Qh[53] = Qh[54][Qh[56]];
        Qh[41] = {
            [Qh[42]] = Qh[43],
            [Qh[44]] = Qh[45],
            [Qh[46]] = Qh[47],
            [Qh[48]] = Qh[49],
            [Qh[50]] = Qh[51],
            [Qh[52]] = Qh[53]
        };
        Qh[7] = {
            [Qh[8]] = Qh[9],
            [Qh[10]] = Qh[11],
            [Qh[12]] = Qh[13],
            [Qh[14]] = Qh[15],
            [Qh[16]] = Qh[17],
            [Qh[18]] = Qh[19],
            [Qh[20]] = Qh[21],
            [Qh[22]] = Qh[23],
            [Qh[24]] = Qh[25],
            [Qh[26]] = Qh[27],
            [Qh[28]] = Qh[29],
            [Qh[30]] = Qh[31],
            [Qh[32]] = Qh[33],
            [Qh[34]] = Qh[35],
            [Qh[36]] = Qh[37],
            [Qh[38]] = Qh[39],
            [Qh[40]] = Qh[41]
        };
        Qh[8] = 173;
        A[Qh[8]] = Qh[7];
        Qh[15] = 33464426659039;
        Qh[7] = r28;
        Qh[11] = r15;
        Qh[9] = "FindFirstChildOfClass";
        Qh[14] = "\x1c?\xde";
        Qh[12] = r16;
        Qh[13] = Qh[12](Qh[14], Qh[15]);
        Qh[9] = Qh[7][Qh[9]];
        Qh[10] = Qh[11][Qh[13]];
        Qh[9] = Qh[9](Qh[7], Qh[10]);
        Qh[7] = {};
        if Qh[9] then
            Qh[14] = "\xca\xbf\x9e\xa1Y\xb0*\xd2";
            Qh[11] = r15;
            Qh[16] = "\xc5\x1c\x12\xf59g\xdb\xd3";
            Qh[15] = 18263267123512;
            Qh[12] = r16;
            Qh[17] = 17754236706891;
            Qh[13] = Qh[12](Qh[14], Qh[15]);
            Qh[10] = Qh[11][Qh[13]];
            Qh[13] = r15;
            Qh[14] = r16;
            Qh[15] = Qh[14](Qh[16], Qh[17]);
            Qh[12] = Qh[13][Qh[15]];
            Qh[15] = 26188198817698;
            Qh[11] = Qh[9][Qh[12]];
            Qh[7][Qh[10]] = Qh[11];
            Qh[11] = r15;
            Qh[12] = r16;
            Qh[17] = 27407467655642;
            Qh[14] = "i_\t'B\xcb\x01\x19";
            Qh[13] = Qh[12](Qh[14], Qh[15]);
            Qh[10] = Qh[11][Qh[13]];
            Qh[16] = "z\xa7Kf\x1dr\xcc\x03";
            Qh[13] = r15;
            Qh[14] = r16;
            Qh[15] = Qh[14](Qh[16], Qh[17]);
            Qh[12] = Qh[13][Qh[15]];
            Qh[11] = Qh[9][Qh[12]];
            Qh[14] = "\x9e\x14\xb1\xcfK\xc4\x90\xeb";
            Qh[17] = 16400967343573;
            Qh[7][Qh[10]] = Qh[11];
            Qh[15] = 3204211656148;
            Qh[11] = r15;
            Qh[12] = r16;
            Qh[13] = Qh[12](Qh[14], Qh[15]);
            Qh[10] = Qh[11][Qh[13]];
            Qh[13] = r15;
            Qh[16] = "\xa3\x94B\xf1\x04dR<";
            Qh[14] = r16;
            Qh[15] = Qh[14](Qh[16], Qh[17]);
            Qh[12] = Qh[13][Qh[15]];
            Qh[17] = 13832010242345;
            Qh[14] = "t4\xf2L\xb1,\x84d";
            Qh[11] = Qh[9][Qh[12]];
            Qh[16] = ":\\\xd0?\xa0\xf4\xd9\x83";
            Qh[7][Qh[10]] = Qh[11];
            Qh[15] = 31099572680849;
            Qh[11] = r15;
            Qh[12] = r16;
            Qh[13] = Qh[12](Qh[14], Qh[15]);
            Qh[10] = Qh[11][Qh[13]];
            Qh[13] = r15;
            Qh[14] = r16;
            Qh[15] = Qh[14](Qh[16], Qh[17]);
            Qh[12] = Qh[13][Qh[15]];
            Qh[11] = Qh[9][Qh[12]];
            Qh[14] = "9b~\x11\xb3\x88,l";
            Qh[7][Qh[10]] = Qh[11];
            Qh[15] = 32612344544082;
            Qh[11] = r15;
            Qh[17] = 15342328896488;
            Qh[12] = r16;
            Qh[16] = "\xe1\xc7r\xd6\xe7\xeaM\xa9";
            Qh[13] = Qh[12](Qh[14], Qh[15]);
            Qh[10] = Qh[11][Qh[13]];
            Qh[13] = r15;
            Qh[14] = r16;
            Qh[15] = Qh[14](Qh[16], Qh[17]);
            Qh[12] = Qh[13][Qh[15]];
            Qh[11] = Qh[9][Qh[12]];
            Qh[14] = "g\xbfHR'\xe5\xa8\xd0";
            Qh[15] = 34154998398496;
            Qh[7][Qh[10]] = Qh[11];
            Qh[11] = r15;
            Qh[17] = 20257776149721;
            Qh[12] = r16;
            Qh[13] = Qh[12](Qh[14], Qh[15]);
            Qh[16] = ".\x04\xf9\x06\xb4:\x81:";
            Qh[10] = Qh[11][Qh[13]];
            Qh[13] = r15;
            Qh[14] = r16;
            Qh[15] = Qh[14](Qh[16], Qh[17]);
            Qh[12] = Qh[13][Qh[15]];
            Qh[11] = Qh[9][Qh[12]];
            Qh[7][Qh[10]] = Qh[11];
        end;
        Qh[12] = function(...)
            H = r28;
            v1 = H[2];
            H = H[1];
            for j, Q in ipairs(H.GetChildren(H)) do
                e = j;
                if Q.IsA(Q, "Sky") then
                    Q.Destroy(Q);
                end; 
            end;
            r38("\xd0\x9d\xd0\xb5\xd0\xb1\xd0\xbe", "\xd0\xa3\xd0\xb4\xd0\xb0\xd0\xbb\xd0\xb5\xd0\xbd\xd0\xbe", 2);
            return; 
        end;
        Qh[23] = "q#\x129\xe8\x86u\x16";
        Qh[11] = function(arg1_49, ...)
            v1 = arg1_49;
            j = A[Qh[8]][v1];
            if not j then
                v3 = tostring(v1);
                v5 = v3.gsub(v3, "%s+", "");
                H = v5.gsub(v5, "rbxassetid://", "");
                if H.match(H, "^%d+$") then
                    e = "rbxassetid://" .. H;
                    v2 = r28;
                    Q = v2[2];
                    v2 = v2[1];
                    for v4, y in ipairs(v2.GetChildren(v2)) do
                        v7 = v4;
                        if y.IsA(y, "Sky") then
                            y.Destroy(y);
                        end; 
                    end;
                    Q = Instance.new("Sky");
                    v4 = "rbxassetid://" .. H;
                    Q.SkyboxBk = v4;
                    Q.SkyboxDn = e;
                    Q.SkyboxFt = e;
                    Q.SkyboxLf = e;
                    Q.SkyboxRt = e;
                    Q.SkyboxUp = e;
                    Q.Parent = r28;
                    r38("\xd0\x9d\xd0\xb5\xd0\xb1\xd0\xbe", "\xd0\x97\xd0\xb0\xd0\xb3\xd1\x80\xd1\x83\xd0\xb6\xd0\xb5\xd0\xbd\xd0\xbe: " .. H, 2);
                else
                    r38("\xd0\x9d\xd0\xb5\xd0\xb1\xd0\xbe", "\xd0\x9d\xd0\xb5\xd0\xb8\xd0\xb7\xd0\xb2\xd0\xb5\xd1\x81\xd1\x82\xd0\xbd\xd1\x8b\xd0\xb9 \xd1\x81\xd0\xba\xd0\xb8\xd0\xb1\xd0\xbe\xd0\xba\xd1\x81", 2);
                end;
                return;
            end;
            r134 = {
                j.Bk,
                j.Dn,
                j.Ft,
                j.Lf,
                j.Rt,
                j.Up
            };
            task.spawn(function(...)
                v5 = r32;
                v5.PreloadAsync(v5, r134);
                return; 
            end);
            v5 = r28;
            e = v5.FindFirstChildOfClass(v5, "Sky");
            if not e then
                e = Instance.new("Sky");
                e.Name = "Sky";
                e.Parent = r28;
            end;
            e.SkyboxBk = j.Bk;
            e.SkyboxDn = j.Dn;
            e.SkyboxFt = j.Ft;
            e.SkyboxLf = j.Lf;
            e.SkyboxRt = j.Rt;
            e.SkyboxUp = j.Up;
            r38("\xd0\x9d\xd0\xb5\xd0\xb1\xd0\xbe", "\xd0\x97\xd0\xb0\xd0\xb3\xd1\x80\xd1\x83\xd0\xb6\xd0\xb5\xd0\xbd\xd0\xbe: " .. v1, 2);
            return; 
        end;
        Qh[24] = 26485237133357;
        Qh[30] = 30116684412616;
        Qh[10] = 45;
        A[Qh[10]] = Qh[11];
        Qh[11] = 46;
        A[Qh[11]] = Qh[12];
        Qh[17] = "\xb9(0\xd9\xe7";
        Qh[14] = r15;
        Qh[18] = 7826240540220;
        Qh[15] = r16;
        Qh[16] = Qh[15](Qh[17], Qh[18]);
        Qh[13] = Qh[14][Qh[16]];
        Qh[16] = r15;
        Qh[17] = r16;
        Qh[19] = "\xf5\xe3\x13\x1cZ\xe2\xe9\x1e\x1e\x90\xf5b";
        Qh[20] = 24972292402540;
        Qh[18] = Qh[17](Qh[19], Qh[20]);
        Qh[19] = "Enum";
        Qh[15] = Qh[16][Qh[18]];
        Qh[46] = 47;
        Qh[18] = Env[Qh[19]];
        Qh[20] = r15;
        Qh[21] = r16;
        Qh[22] = Qh[21](Qh[23], Qh[24]);
        Qh[40] = 27719026356843;
        Qh[19] = Qh[20][Qh[22]];
        Qh[22] = "\xd5Q\xb0-\x17";
        Qh[17] = Qh[18][Qh[19]];
        Qh[19] = r15;
        Qh[20] = r16;
        Qh[26] = 14268064487924;
        Qh[37] = "\x9d\x0b\x97#cy\xd2B";
        Qh[23] = 13624016148680;
        Qh[21] = Qh[20](Qh[22], Qh[23]);
        Qh[18] = Qh[19][Qh[21]];
        Qh[16] = Qh[17][Qh[18]];
        Qh[25] = "\x15\xd2\xee]\x19\xfd#\xb8";
        Qh[18] = r15;
        Qh[21] = "\x1bnX1-\xca\x18";
        Qh[19] = r16;
        Qh[32] = 31761493866950;
        Qh[22] = 7665706880497;
        Qh[20] = Qh[19](Qh[21], Qh[22]);
        Qh[22] = "\x96\xf2c\xc9\x9b\xa8\xac\xd9\x8cnW\x98\xaa\x97\xf9I\x85vK\x05\x17\xdcn\x89";
        Qh[17] = Qh[18][Qh[20]];
        Qh[23] = 4070478546791;
        Qh[19] = r15;
        Qh[20] = r16;
        Qh[21] = Qh[20](Qh[22], Qh[23]);
        Qh[18] = Qh[19][Qh[21]];
        Qh[14] = {
            [Qh[15]] = Qh[16],
            [Qh[17]] = Qh[18]
        };
        Qh[22] = 4191131617183;
        Qh[16] = r15;
        Qh[17] = r16;
        Qh[20] = 15336992349157;
        Qh[21] = "\x89\x8c\xfa\xd1\xa4\x96\xcb\xd1K'bQ";
        Qh[19] = "&\x82\xf5z\x86E\xd4\xf2";
        Qh[18] = Qh[17](Qh[19], Qh[20]);
        Qh[15] = Qh[16][Qh[18]];
        Qh[18] = r15;
        Qh[19] = r16;
        Qh[20] = Qh[19](Qh[21], Qh[22]);
        Qh[17] = Qh[18][Qh[20]];
        Qh[21] = "Enum";
        Qh[20] = Env[Qh[21]];
        Qh[22] = r15;
        Qh[23] = r16;
        Qh[27] = "0&v=\x8e\x8d\r\xd9";
        Qh[24] = Qh[23](Qh[25], Qh[26]);
        Qh[21] = Qh[22][Qh[24]];
        Qh[19] = Qh[20][Qh[21]];
        Qh[25] = 32392297446123;
        Qh[21] = r15;
        Qh[24] = "\xab\xe4 \xe8@\x06\x08\x03";
        Qh[22] = r16;
        Qh[23] = Qh[22](Qh[24], Qh[25]);
        Qh[28] = 23411698166421;
        Qh[20] = Qh[21][Qh[23]];
        Qh[24] = 34871554752366;
        Qh[18] = Qh[19][Qh[20]];
        Qh[20] = r15;
        Qh[21] = r16;
        Qh[23] = "]Ee\x05\xed`\x15";
        Qh[33] = "|\x1c\x87\xbb\x7fl\x1f\xbf";
        Qh[22] = Qh[21](Qh[23], Qh[24]);
        Qh[19] = Qh[20][Qh[22]];
        Qh[21] = r15;
        Qh[22] = r16;
        Qh[24] = "\x17\x95d1#\xach\xf8\xb0E\xdf\xe2<\xc1\xafb\xf4\xd4\x94\nei\xa2\xdc";
        Qh[25] = 9539054489945;
        Qh[23] = Qh[22](Qh[24], Qh[25]);
        Qh[22] = 22733207382361;
        Qh[20] = Qh[21][Qh[23]];
        Qh[21] = "\xdbFT\xe9\xaf\xaf\xd1\xe5 \xf4\xdd\x00\x00";
        Qh[16] = {
            [Qh[17]] = Qh[18],
            [Qh[19]] = Qh[20]
        };
        Qh[18] = r15;
        Qh[19] = r16;
        Qh[20] = Qh[19](Qh[21], Qh[22]);
        Qh[23] = "\x92\x0e\xcc3\xaa\x97\rA\x8a\xc6i\x0b";
        Qh[24] = 25794654678763;
        Qh[17] = Qh[18][Qh[20]];
        Qh[20] = r15;
        Qh[21] = r16;
        Qh[22] = Qh[21](Qh[23], Qh[24]);
        Qh[19] = Qh[20][Qh[22]];
        Qh[23] = "Enum";
        Qh[29] = "\xad\xa9L\x1aF\x94]~";
        Qh[22] = Env[Qh[23]];
        Qh[24] = r15;
        Qh[25] = r16;
        Qh[35] = "\xca\xb4\xdb\x19l\x86\xad7";
        Qh[26] = Qh[25](Qh[27], Qh[28]);
        Qh[23] = Qh[24][Qh[26]];
        Qh[21] = Qh[22][Qh[23]];
        Qh[26] = "2\x12\xb4\xcc\xfc]\xf2X\x07:\xe8L\xb1";
        Qh[23] = r15;
        Qh[24] = r16;
        Qh[27] = 20594398209398;
        Qh[25] = Qh[24](Qh[26], Qh[27]);
        Qh[22] = Qh[23][Qh[25]];
        Qh[38] = 34002435390937;
        Qh[25] = "\x19\x7f\xc4\xa0i\x84\xab";
        Qh[20] = Qh[21][Qh[22]];
        Qh[51] = function(...)
            if r43.ShootButton then
                pcall(function(...)
                    v5 = r43.ShootButton;
                    v5.Destroy(v5);
                    return; 
                end);
                r43.ShootButton = nil;
            end;
            v1 = Instance.new("ScreenGui");
            v1.Name = "ShootButton";
            v1.ResetOnSpawn = false;
            v1.IgnoreGuiInset = true;
            v1.ZIndexBehavior = Enum.ZIndexBehavior.Sibling;
            v3 = r34;
            v1.Parent = v3.WaitForChild(v3, "PlayerGui");
            r135 = Instance.new("TextButton");
            r135.Size = UDim2.new(0, 100, 0, 50);
            r135.Position = UDim2.new(0.5, -50, .6, 0);
            r135.BackgroundColor3 = Color3.fromRGB(20, 20, 20);
            r135.BackgroundTransparency = .15;
            r135.TextColor3 = Color3.fromRGB(255, 255, 255);
            r135.Text = "\xd0\x92\xd1\x8b\xd1\x81\xd1\x82\xd1\x80\xd0\xb5\xd0\xbb";
            r135.TextSize = 18;
            r135.Font = Enum.Font.GothamBold;
            r135.BorderSizePixel = 2;
            r135.BorderColor3 = Color3.fromRGB(60, 60, 60);
            r135.BorderTransparency = .3;
            r135.Parent = v1;
            r135.ClipsDescendants = true;
            H = Instance.new("UICorner");
            H.CornerRadius = UDim.new(0, 12);
            H.Parent = r135;
            r136 = false;
            v5 = r135.InputBegan;
            v5.Connect(v5, function(arg1_50, ...)
                v1 = arg1_50;
                if v1.UserInputType == Enum.UserInputType.MouseButton1 or v1.UserInputType == Enum.UserInputType.Touch then
                    r136 = false;
                    r137 = v1.Position;
                    r139 = v1.Position;
                    r138 = r135.Position;
                    r135.BackgroundColor3 = Color3.fromRGB(60, 60, 60);
                    r135.BackgroundTransparency = .1;
                end;
                return; 
            end);
            v5 = r135.InputChanged;
            v5.Connect(v5, function(arg1_51, ...)
                v1 = arg1_51;
                if not r137 then
                    return;
                end;
                if v1.UserInputType == Enum.UserInputType.MouseMovement or v1.UserInputType == Enum.UserInputType.Touch then
                    j = v1.Position - r137;
                    if j.Magnitude > 10 then
                        r136 = true;
                    end;
                    if r136 then
                        r135.Position = UDim2.new(r138.v2.Scale, r138.v2.Offset + j.v2, r138.v3.Scale, r138.v3.Offset + j.v3);
                    end;
                end;
                return; 
            end);
            v5 = r135.InputEnded;
            v5.Connect(v5, function(arg1_52, ...)
                v1 = arg1_52;
                if v1.UserInputType == Enum.UserInputType.MouseButton1 or v1.UserInputType == Enum.UserInputType.Touch then
                    r135.BackgroundColor3 = Color3.fromRGB(20, 20, 20);
                    r135.BackgroundTransparency = .15;
                    if r139 and (v1.Position - r139).Magnitude < 10 then
                        task.spawn(function(...)
                            if not r34.Character then
                                return;
                            end;
                            if not r51() then
                                r38("\xd0\x92\xd1\x8b\xd1\x81\xd1\x82\xd1\x80\xd0\xb5\xd0\xbb", "\xd0\x9e\xd1\x80\xd1\x83\xd0\xb6\xd0\xb8\xd0\xb5 \xd0\xbd\xd0\xb5 \xd0\xbd\xd0\xb0\xd0\xb9\xd0\xb4\xd0\xb5\xd0\xbd\xd0\xbe", 2);
                                return;
                            end;
                            j = math.huge;
                            v5 = r34.Character;
                            if not v5.FindFirstChild(v5, "HumanoidRootPart") then
                                return;
                            end;
                            v4 = r24;
                            Q = v4[3];
                            e = v4[2];
                            v4 = "ipairs";
                            for Q, v7 in ipairs(v4.GetPlayers(v4)) do
                                v2 = Q;
                                if v7 ~= r34 and v7.Character then
                                    if r47(v7) and r55(v7) then
                                        v5 = v7.Character;
                                        y = v5.FindFirstChild(v5, "HumanoidRootPart");
                                        if y then
                                            w = v5.FindFirstChild(v5, "HumanoidRootPart").Position - y.Position;
                                            v5 = (w.Magnitude and w) < math.huge;
                                        end;
                                    end;
                                end; 
                            end;
                            if not nil then
                                r38("\xd0\x92\xd1\x8b\xd1\x81\xd1\x82\xd1\x80\xd0\xb5\xd0\xbb", "\xd0\xa3\xd0\xb1\xd0\xb8\xd0\xb9\xd1\x86\xd0\xb0 \xd0\xbd\xd0\xb5 \xd0\xbd\xd0\xb0\xd0\xb9\xd0\xb4\xd0\xb5\xd0\xbd", 2);
                                return;
                            end;
                            e = nil.Character;
                            Q = e.FindFirstChild(e, "HumanoidRootPart");
                            if not Q then
                                return;
                            end;
                            r56(r35.CFrame.Position, Q.Position, Color3.fromRGB(180, 50, 255), .2);
                            v2 = Q.AssemblyLinearVelocity;
                            r35.CFrame = CFrame.lookAt(r35.CFrame.Position, Q.Position + Vector3.new(v2.v2, 0, v2.Z) * .1);
                            pcall(function(...)
                                v5 = r30;
                                v5.SendKeyEvent(v5, true, Enum.KeyCode.MouseButton1, false, game);
                                task.wait(.05);
                                v5 = r30;
                                v5.SendKeyEvent(v5, false, Enum.KeyCode.MouseButton1, false, game);
                                return; 
                            end);
                            return; 
                        end);
                    end;
                    r136 = false;
                end;
                return; 
            end);
            r43.ShootButton = v1;
            return v1; 
        end;
        Qh[26] = 27584222589484;
        Qh[27] = 22783538899313;
        Qh[22] = r15;
        Qh[23] = r16;
        Qh[24] = Qh[23](Qh[25], Qh[26]);
        Qh[26] = "\xf7y\xb0\xa6\x93\xfe\xa5[\x92\xba3\x1aR\xb9z\xbb0yI m[\t\xa3h\x89`";
        Qh[21] = Qh[22][Qh[24]];
        Qh[23] = r15;
        Qh[24] = r16;
        Qh[25] = Qh[24](Qh[26], Qh[27]);
        Qh[22] = Qh[23][Qh[25]];
        Qh[36] = 8520598065023;
        Qh[26] = 1316740465253;
        Qh[24] = 25102854139305;
        Qh[18] = {
            [Qh[19]] = Qh[20],
            [Qh[21]] = Qh[22]
        };
        Qh[20] = r15;
        Qh[25] = "\xb5\xd8\x07\x13\xb3o\xbcO,\xbf>\x06";
        Qh[21] = r16;
        Qh[23] = "J-uA\x07";
        Qh[22] = Qh[21](Qh[23], Qh[24]);
        Qh[19] = Qh[20][Qh[22]];
        Qh[22] = r15;
        Qh[23] = r16;
        Qh[24] = Qh[23](Qh[25], Qh[26]);
        Qh[21] = Qh[22][Qh[24]];
        Qh[25] = "Enum";
        Qh[24] = Env[Qh[25]];
        Qh[26] = r15;
        Qh[27] = r16;
        Qh[28] = Qh[27](Qh[29], Qh[30]);
        Qh[25] = Qh[26][Qh[28]];
        Qh[23] = Qh[24][Qh[25]];
        Qh[29] = 8349130526511;
        Qh[28] = "\xcb\xa1\x1c\x14\xa5";
        Qh[25] = r15;
        Qh[26] = r16;
        Qh[27] = Qh[26](Qh[28], Qh[29]);
        Qh[31] = "B\xa7\xf4}\xdc\xc3\x8fF";
        Qh[28] = 1590224175844;
        Qh[24] = Qh[25][Qh[27]];
        Qh[22] = Qh[23][Qh[24]];
        Qh[24] = r15;
        Qh[29] = 18382114595183;
        Qh[25] = r16;
        Qh[27] = "\x1a\xf9\xb3\xae\xf7R\x9a";
        Qh[26] = Qh[25](Qh[27], Qh[28]);
        Qh[28] = "\xe8\xa8![w\x03\x86\xc1\x1d\xa4B\x87\xc4\x8c\x0e\xb8\xfa;\xbe\xdf\xe5Lt";
        Qh[23] = Qh[24][Qh[26]];
        Qh[25] = r15;
        Qh[26] = r16;
        Qh[27] = Qh[26](Qh[28], Qh[29]);
        Qh[28] = 530371723510;
        Qh[24] = Qh[25][Qh[27]];
        Qh[20] = {
            [Qh[21]] = Qh[22],
            [Qh[23]] = Qh[24]
        };
        Qh[22] = r15;
        Qh[23] = r16;
        Qh[27] = "\xda\xa9\xd1\x15m^w\xd1g\xa8k\xe6";
        Qh[25] = "p{\x13M\x06";
        Qh[26] = 26016137178962;
        Qh[24] = Qh[23](Qh[25], Qh[26]);
        Qh[21] = Qh[22][Qh[24]];
        Qh[24] = r15;
        Qh[25] = r16;
        Qh[26] = Qh[25](Qh[27], Qh[28]);
        Qh[27] = "Enum";
        Qh[23] = Qh[24][Qh[26]];
        Qh[26] = Env[Qh[27]];
        Qh[28] = r15;
        Qh[29] = r16;
        Qh[30] = Qh[29](Qh[31], Qh[32]);
        Qh[27] = Qh[28][Qh[30]];
        Qh[25] = Qh[26][Qh[27]];
        Qh[27] = r15;
        Qh[30] = "\xdc\x8c\xd4\xe5\xd9";
        Qh[28] = r16;
        Qh[31] = 15583536602200;
        Qh[29] = Qh[28](Qh[30], Qh[31]);
        Qh[26] = Qh[27][Qh[29]];
        Qh[24] = Qh[25][Qh[26]];
        Qh[26] = r15;
        Qh[31] = 6875839253633;
        Qh[29] = "\x8e\xdb\xa2\xc4%%\xe4";
        Qh[27] = r16;
        Qh[30] = 29966304310914;
        Qh[28] = Qh[27](Qh[29], Qh[30]);
        Qh[25] = Qh[26][Qh[28]];
        Qh[27] = r15;
        Qh[28] = r16;
        Qh[30] = "pY\xbe\x84\xa5\xae\xe8K\x11\xa1\xcf\xd8\xcd\xb3u\xa9,\xb1\xa8\x0eR\x02$\xa2\xf9\x98d+";
        Qh[34] = 31848131672558;
        Qh[29] = Qh[28](Qh[30], Qh[31]);
        Qh[26] = Qh[27][Qh[29]];
        Qh[67] = "y\x9b[/i\xfei\x0e";
        Qh[22] = {
            [Qh[23]] = Qh[24],
            [Qh[25]] = Qh[26]
        };
        Qh[28] = 10515755488032;
        Qh[24] = r15;
        Qh[27] = ">6\xcb\xbd";
        Qh[30] = 2608172745918;
        Qh[29] = "K\xa4p6\xa9\x1c\xf3\x91\xb6=%\x04";
        Qh[25] = r16;
        Qh[26] = Qh[25](Qh[27], Qh[28]);
        Qh[23] = Qh[24][Qh[26]];
        Qh[26] = r15;
        Qh[27] = r16;
        Qh[28] = Qh[27](Qh[29], Qh[30]);
        Qh[29] = "Enum";
        Qh[25] = Qh[26][Qh[28]];
        Qh[28] = Env[Qh[29]];
        Qh[30] = r15;
        Qh[31] = r16;
        Qh[32] = Qh[31](Qh[33], Qh[34]);
        Qh[29] = Qh[30][Qh[32]];
        Qh[32] = "s.\xa8\x82";
        Qh[27] = Qh[28][Qh[29]];
        Qh[43] = function(arg1_53, ...)
            r140 = arg1_53;
            if not r140 or not r140.Parent then
                return;
            end;
            j = r34.Character;
            if j then
                j = r34.Character;
                v3 = j.FindFirstChild(j, "HumanoidRootPart");
            end;
            r141 = j;
            if not r141 then
                return;
            end;
            pcall(function(...)
                firetouchinterest(r141, r140, 0);
                task.wait(.05);
                firetouchinterest(r141, r140, 1);
                return; 
            end);
            return; 
        end;
        Qh[29] = r15;
        Qh[30] = r16;
        Qh[33] = 1816620516173;
        Qh[31] = Qh[30](Qh[32], Qh[33]);
        Qh[28] = Qh[29][Qh[31]];
        Qh[32] = 16232188910982;
        Qh[26] = Qh[27][Qh[28]];
        Qh[28] = r15;
        Qh[31] = "_\xe3\xdd'5\xb9\xeb";
        Qh[29] = r16;
        Qh[30] = Qh[29](Qh[31], Qh[32]);
        Qh[27] = Qh[28][Qh[30]];
        Qh[71] = 28170023170877;
        Qh[32] = "5\xd1\x1e\xf9\xbf\x11\x8aG\x1ft\x08\xf3>\x15\x8a\x9c\xc2\xc7\xb6\xbe\xd1\xa0\x04-";
        Qh[29] = r15;
        Qh[30] = r16;
        Qh[33] = 4329466447840;
        Qh[31] = Qh[30](Qh[32], Qh[33]);
        Qh[28] = Qh[29][Qh[31]];
        Qh[31] = "\ri\x07\xe2\xba5\xbfB(\n\xaf\xe2";
        Qh[24] = {
            [Qh[25]] = Qh[26],
            [Qh[27]] = Qh[28]
        };
        Qh[26] = r15;
        Qh[29] = "\xa6\xf1\xe6\x99\xc3";
        Qh[30] = 5887099062965;
        Qh[62] = "\xd3\xcf\xf7\x82\x1d";
        Qh[27] = r16;
        Qh[28] = Qh[27](Qh[29], Qh[30]);
        Qh[25] = Qh[26][Qh[28]];
        Qh[32] = 31569181260140;
        Qh[28] = r15;
        Qh[29] = r16;
        Qh[30] = Qh[29](Qh[31], Qh[32]);
        Qh[27] = Qh[28][Qh[30]];
        Qh[31] = "Enum";
        Qh[30] = Env[Qh[31]];
        Qh[32] = r15;
        Qh[33] = r16;
        Qh[65] = 15142969023371;
        Qh[34] = Qh[33](Qh[35], Qh[36]);
        Qh[31] = Qh[32][Qh[34]];
        Qh[29] = Qh[30][Qh[31]];
        Qh[34] = "5\xf7m\xe6\xd2";
        Qh[31] = r15;
        Qh[32] = r16;
        Qh[35] = 20155163567273;
        Qh[33] = Qh[32](Qh[34], Qh[35]);
        Qh[30] = Qh[31][Qh[33]];
        Qh[34] = 28777106617432;
        Qh[28] = Qh[29][Qh[30]];
        Qh[33] = "<$\xd3\x85\x9d\x93!";
        Qh[30] = r15;
        Qh[31] = r16;
        Qh[32] = Qh[31](Qh[33], Qh[34]);
        Qh[29] = Qh[30][Qh[32]];
        Qh[31] = r15;
        Qh[34] = "\x95\x97\x15'&\x96\xc7\xfaJ>k\x1b\x95\x0b\xbfQ\xbe\xb5\x7f\x1b\xd45\xb8";
        Qh[32] = r16;
        Qh[35] = 8207780712174;
        Qh[33] = Qh[32](Qh[34], Qh[35]);
        Qh[30] = Qh[31][Qh[33]];
        Qh[26] = {
            [Qh[27]] = Qh[28],
            [Qh[29]] = Qh[30]
        };
        Qh[28] = r15;
        Qh[31] = "c\x91&%";
        Qh[33] = "\xf5\xd6I\x16\xa1\t\x9cU\xf2#\x08\xc2";
        Qh[32] = 29694218057219;
        Qh[29] = r16;
        Qh[30] = Qh[29](Qh[31], Qh[32]);
        Qh[27] = Qh[28][Qh[30]];
        Qh[30] = r15;
        Qh[31] = r16;
        Qh[34] = 16325941894578;
        Qh[32] = Qh[31](Qh[33], Qh[34]);
        Qh[33] = "Enum";
        Qh[29] = Qh[30][Qh[32]];
        Qh[32] = Env[Qh[33]];
        Qh[34] = r15;
        Qh[35] = r16;
        Qh[36] = Qh[35](Qh[37], Qh[38]);
        Qh[33] = Qh[34][Qh[36]];
        Qh[31] = Qh[32][Qh[33]];
        Qh[33] = r15;
        Qh[37] = 17921544118425;
        Qh[34] = r16;
        Qh[36] = "\xfauA;";
        Qh[35] = Qh[34](Qh[36], Qh[37]);
        Qh[32] = Qh[33][Qh[35]];
        Qh[30] = Qh[31][Qh[32]];
        Qh[35] = "\xaa\x9c\x900O\xe3l";
        Qh[36] = 1735968015144;
        Qh[37] = 26402285891590;
        Qh[32] = r15;
        Qh[33] = r16;
        Qh[34] = Qh[33](Qh[35], Qh[36]);
        Qh[36] = "Q\x82y\x90a\xd5\xec\x82|w\xfe\x04\x194\x05\xf0\x83\xa7*_c\xffc";
        Qh[31] = Qh[32][Qh[34]];
        Qh[33] = r15;
        Qh[34] = r16;
        Qh[35] = Qh[34](Qh[36], Qh[37]);
        Qh[36] = 26838822154449;
        Qh[34] = 5520710912522;
        Qh[32] = Qh[33][Qh[35]];
        Qh[28] = {
            [Qh[29]] = Qh[30],
            [Qh[31]] = Qh[32]
        };
        Qh[30] = r15;
        Qh[31] = r16;
        Qh[33] = "1\xbe\xcf\xea=\\s\x929\r";
        Qh[35] = "?\x0e\x80@b\xb4\x80d\xecM\xb5\xf2";
        Qh[32] = Qh[31](Qh[33], Qh[34]);
        Qh[29] = Qh[30][Qh[32]];
        Qh[32] = r15;
        Qh[41] = function(...)
            v1 = {};
            j = r34.Character;
            v3 = j;
            if not (v3 and j.FindFirstChild(j, "HumanoidRootPart")) then
                return v1;
            end;
            Q = r26;
            e = Q[3];
            H = Q[2];
            Q = "pairs";
            for e, v2 in pairs(Q.GetChildren(Q)) do
                v4 = e;
                if v2.FindFirstChild(v2, "CoinContainer") then
                    v8 = v7.GetChildren;
                    w = v8[2];
                    y = v8[1];
                    for v6, v8 in pairs(v8(v7)) do
                        P = v6;
                        if v8.Name == "Coin_Server" and (v8.IsA(v8, "BasePart") and v8.FindFirstChild(v8, "TouchInterest")) then
                            table.insert({}, {
                                ["part"] = v8,
                                ["distance"] = ((v3 and j.FindFirstChild(j, "HumanoidRootPart")).Position - v8.Position).Magnitude
                            });
                        end; 
                    end;
                end; 
            end;
            table.sort(v1, function(arg1_54, arg2_54, ...)
                return arg1_54.distance < arg2_54.distance; 
            end);
            return v1; 
        end;
        Qh[39] = "&\x94\xa5\x1c\x14)\x01\xc6";
        Qh[33] = r16;
        Qh[34] = Qh[33](Qh[35], Qh[36]);
        Qh[31] = Qh[32][Qh[34]];
        Qh[35] = "Enum";
        Qh[34] = Env[Qh[35]];
        Qh[36] = r15;
        Qh[37] = r16;
        Qh[38] = Qh[37](Qh[39], Qh[40]);
        Qh[39] = 453023236306;
        Qh[35] = Qh[36][Qh[38]];
        Qh[38] = "\x17\x13\x8a\xd4'YV\xa3\x8c\xe0";
        Qh[33] = Qh[34][Qh[35]];
        Qh[35] = r15;
        Qh[36] = r16;
        Qh[37] = Qh[36](Qh[38], Qh[39]);
        Qh[34] = Qh[35][Qh[37]];
        Qh[56] = "Tab";
        Qh[32] = Qh[33][Qh[34]];
        Qh[38] = 3580575745;
        Qh[34] = r15;
        Qh[35] = r16;
        Qh[37] = "\xca\xd3\xd4\xe7\xce\xa5T";
        Qh[39] = 29309250549072;
        Qh[36] = Qh[35](Qh[37], Qh[38]);
        Qh[33] = Qh[34][Qh[36]];
        Qh[35] = r15;
        Qh[38] = "kd\xb1K5\x7f\x8d\xf8\xdd!\x0e\x80\x88\xaf\xd2C\xf8\x10\xe6\xdcd\x1e\xde";
        Qh[36] = r16;
        Qh[37] = Qh[36](Qh[38], Qh[39]);
        Qh[34] = Qh[35][Qh[37]];
        Qh[30] = {
            [Qh[31]] = Qh[32],
            [Qh[33]] = Qh[34]
        };
        Qh[12] = {
            [Qh[13]] = Qh[14],
            [Qh[15]] = Qh[16],
            [Qh[17]] = Qh[18],
            [Qh[19]] = Qh[20],
            [Qh[21]] = Qh[22],
            [Qh[23]] = Qh[24],
            [Qh[25]] = Qh[26],
            [Qh[27]] = Qh[28],
            [Qh[29]] = Qh[30]
        };
        Qh[17] = "Enum";
        Qh[13] = 48;
        A[Qh[13]] = Qh[12];
        Qh[22] = 18835137831490;
        Qh[32] = 31801922959832;
        Qh[31] = "\xd6\xc6\xf9;\x05\xde\xc1\x87";
        Qh[16] = Env[Qh[17]];
        Qh[18] = r15;
        Qh[19] = r16;
        Qh[35] = "\xe3\\\x93\x9f\xfaIu\x8d";
        Qh[34] = 4825331566790;
        Qh[21] = " *\xf14;\n\x1cJ";
        Qh[20] = Qh[19](Qh[21], Qh[22]);
        Qh[17] = Qh[18][Qh[20]];
        Qh[20] = "W\xd6\xf80O";
        Qh[15] = Qh[16][Qh[17]];
        Qh[24] = 15412259593224;
        Qh[38] = 30045680760487;
        Qh[17] = r15;
        Qh[18] = r16;
        Qh[21] = 26019717754708;
        Qh[19] = Qh[18](Qh[20], Qh[21]);
        Qh[16] = Qh[17][Qh[19]];
        Qh[14] = Qh[15][Qh[16]];
        Qh[16] = r15;
        Qh[17] = r16;
        Qh[19] = "\x9e\x83\xe2%_";
        Qh[20] = 29839622272583;
        Qh[23] = "~\x06\x16\x19\xa4:op";
        Qh[18] = Qh[17](Qh[19], Qh[20]);
        Qh[15] = Qh[16][Qh[18]];
        Qh[19] = "Enum";
        Qh[36] = 3643394868896;
        Qh[18] = Env[Qh[19]];
        Qh[20] = r15;
        Qh[21] = r16;
        Qh[22] = Qh[21](Qh[23], Qh[24]);
        Qh[19] = Qh[20][Qh[22]];
        Qh[17] = Qh[18][Qh[19]];
        Qh[19] = r15;
        Qh[23] = 6418882268077;
        Qh[20] = r16;
        Qh[26] = 22288098863242;
        Qh[22] = "\xff\x99\x9b!]o\x85F";
        Qh[21] = Qh[20](Qh[22], Qh[23]);
        Qh[18] = Qh[19][Qh[21]];
        Qh[30] = 23281324878425;
        Qh[22] = 24621554494665;
        Qh[16] = Qh[17][Qh[18]];
        Qh[21] = "vY\x02\x0c\xec\xfd0i";
        Qh[18] = r15;
        Qh[19] = r16;
        Qh[25] = "\x7f\xbe\x05R(k\xb5\xae";
        Qh[20] = Qh[19](Qh[21], Qh[22]);
        Qh[27] = "\xaeI\xd0:Bg\x92\xb6";
        Qh[29] = "\xa4L\x12%\xc3\xd8\x16n";
        Qh[21] = "Enum";
        Qh[17] = Qh[18][Qh[20]];
        Qh[20] = Env[Qh[21]];
        Qh[64] = 19744991814634;
        Qh[22] = r15;
        Qh[23] = r16;
        Qh[28] = 18951858430585;
        Qh[24] = Qh[23](Qh[25], Qh[26]);
        Qh[21] = Qh[22][Qh[24]];
        Qh[42] = function(arg1_55, ...)
            v1 = arg1_55;
            if not v1 or (not v1.Parent or not v1.FindFirstChild(v1, "TouchInterest")) then
                return false;
            end;
            j = r34.Character;
            if not j then
                return false;
            end;
            H = j.FindFirstChild(j, "HumanoidRootPart");
            e = j.FindFirstChildOfClass(j, "Humanoid");
            if not H or not e then
                return false;
            end;
            Q = v1.Position + Vector3.new(0, 2, 0);
            if (H.Position - Q).Magnitude < 5 then
                return true;
            end;
            if r43.CurrentTween then
                pcall(function(...)
                    v5 = r43.CurrentTween;
                    v5.Cancel(v5);
                    return; 
                end);
            end;
            v4 = r29;
            r43.CurrentTween = v4.Create(v4, H, TweenInfo.new((H.Position - Q).Magnitude / r42.AutoFarmSpeed, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                ["CFrame"] = CFrame.new(Q)
            });
            e.Sit = true;
            v5 = r43.CurrentTween;
            v5.Play(v5);
            r142 = false;
            v5 = r43.CurrentTween.Completed;
            r143 = v5.Connect(v5, function(...)
                r142 = true;
                A[p](r143);
                return; 
            end);
            tick();
            w = not r142;
            y = r42.AutoFarmEnabled;
            while not w do
                if w then
                    task.wait(.1);
                    if not v1 or (not v1.Parent or not v1.FindFirstChild(v1, "TouchInterest")) then
                        if r43.CurrentTween then
                            pcall(function(...)
                                v5 = r43.CurrentTween;
                                v5.Cancel(v5);
                                return; 
                            end);
                            break;
                        end;
                        j.FindFirstChildOfClass(j, "Humanoid").Sit = false;
                        return false;
                    else
                        if tick() - v5() > 30 then
                            if r43.CurrentTween then
                                pcall(function(...)
                                    v5 = r43.CurrentTween;
                                    v5.Cancel(v5);
                                    return; 
                                end);
                                break;
                            end;
                            j.FindFirstChildOfClass(j, "Humanoid").Sit = false;
                            return false;
                        else
                        end;
                    end;
                end;
                e.Sit = false;
                return r142; 
            end;
            y = r42.AutoFarmEnabled; 
        end;
        Qh[25] = 16934637756109;
        Qh[19] = Qh[20][Qh[21]];
        Qh[21] = r15;
        Qh[22] = r16;
        Qh[24] = "]{^0\xf1vt\xee2\x83\xfc\x9e]";
        Qh[23] = Qh[22](Qh[24], Qh[25]);
        Qh[24] = 27229727240583;
        Qh[33] = "\xed\xd4\xae\xf8\xda\xfc\x8d\xed";
        Qh[20] = Qh[21][Qh[23]];
        Qh[18] = Qh[19][Qh[20]];
        Qh[20] = r15;
        Qh[21] = r16;
        Qh[23] = "p\x08zh}<\xd5\x95P\xc2a@\xe6";
        Qh[22] = Qh[21](Qh[23], Qh[24]);
        Qh[19] = Qh[20][Qh[22]];
        Qh[23] = "Enum";
        Qh[22] = Env[Qh[23]];
        Qh[24] = r15;
        Qh[25] = r16;
        Qh[26] = Qh[25](Qh[27], Qh[28]);
        Qh[23] = Qh[24][Qh[26]];
        Qh[21] = Qh[22][Qh[23]];
        Qh[23] = r15;
        Qh[24] = r16;
        Qh[26] = "B\x8b\xd4\xd4\xbc";
        Qh[27] = 18751258272283;
        Qh[25] = Qh[24](Qh[26], Qh[27]);
        Qh[22] = Qh[23][Qh[25]];
        Qh[26] = 8277544046350;
        Qh[20] = Qh[21][Qh[22]];
        Qh[22] = r15;
        Qh[25] = "\x91v\xbcxT";
        Qh[23] = r16;
        Qh[24] = Qh[23](Qh[25], Qh[26]);
        Qh[25] = "Enum";
        Qh[21] = Qh[22][Qh[24]];
        Qh[24] = Env[Qh[25]];
        Qh[26] = r15;
        Qh[27] = r16;
        Qh[28] = Qh[27](Qh[29], Qh[30]);
        Qh[29] = 24638357351633;
        Qh[25] = Qh[26][Qh[28]];
        Qh[23] = Qh[24][Qh[25]];
        Qh[28] = "s\x1c\xb3\x07\xcb";
        Qh[25] = r15;
        Qh[26] = r16;
        Qh[37] = "\xbb\x13W\x0f\x02\xb6\xd5\x0b";
        Qh[27] = Qh[26](Qh[28], Qh[29]);
        Qh[24] = Qh[25][Qh[27]];
        Qh[22] = Qh[23][Qh[24]];
        Qh[28] = 4662353217659;
        Qh[24] = r15;
        Qh[25] = r16;
        Qh[47] = 49;
        Qh[27] = "\n\x16\xac>z";
        Qh[26] = Qh[25](Qh[27], Qh[28]);
        Qh[27] = "Enum";
        Qh[23] = Qh[24][Qh[26]];
        Qh[26] = Env[Qh[27]];
        Qh[28] = r15;
        Qh[29] = r16;
        Qh[30] = Qh[29](Qh[31], Qh[32]);
        Qh[27] = Qh[28][Qh[30]];
        Qh[31] = 9609148813690;
        Qh[25] = Qh[26][Qh[27]];
        Qh[30] = "$\x02\x84\xce";
        Qh[27] = r15;
        Qh[28] = r16;
        Qh[29] = Qh[28](Qh[30], Qh[31]);
        Qh[30] = 33439459835091;
        Qh[26] = Qh[27][Qh[29]];
        Qh[24] = Qh[25][Qh[26]];
        Qh[29] = "\x10\x06U\xa7";
        Qh[26] = r15;
        Qh[27] = r16;
        Qh[28] = Qh[27](Qh[29], Qh[30]);
        Qh[53] = function(...)
            H = r24;
            j = H[3];
            H = H[1];
            for j, Q in H, ipairs(H.GetPlayers(H)) do
                e = j;
                v4 = r34;
                if Q == v4 then
                    if r42.ChamsEnabled then
                        r119(Q);
                    else
                        if r43.ChamsPartsList[Q.UserId] then
                            r121(Q);
                        end;
                    end;
                else
                    if not Q.Character then
                        
                    end;
                    v4 = r49(Q);
                    if r42.MurderESP and v4 == "\xd0\xa3\xd0\xb1\xd0\xb8\xd0\xb9\xd1\x86\xd0\xb0" then
                        r127(Q, r44.Murder);
                    else
                        if r42.SheriffESP and v4 == "\xd0\xa8\xd0\xb5\xd1\x80\xd0\xb8\xd1\x84" then
                            r127(Q, r44.Sheriff);
                        else
                            if r42.InnocentESP and v5(Q) == "\xd0\x9d\xd0\xb5\xd0\xb2\xd0\xb8\xd0\xbd\xd0\xbd\xd1\x8b\xd0\xb9" then
                                r127(Q, r44.Innocent);
                            else
                                r128(Q);
                            end;
                            if r42.ChamsEnabled then
                                r119(Q);
                            else
                                if r43.ChamsPartsList[Q.UserId] then
                                    r121(Q);
                                end;
                            end;
                        end;
                    end;
                end; 
            end;
            return; 
        end;
        Qh[29] = "Enum";
        Qh[25] = Qh[26][Qh[28]];
        Qh[28] = Env[Qh[29]];
        Qh[30] = r15;
        Qh[31] = r16;
        Qh[32] = Qh[31](Qh[33], Qh[34]);
        Qh[29] = Qh[30][Qh[32]];
        Qh[27] = Qh[28][Qh[29]];
        Qh[32] = "\xf3Y\x89\xf2\xad";
        Qh[29] = r15;
        Qh[30] = r16;
        Qh[33] = 4118994765694;
        Qh[31] = Qh[30](Qh[32], Qh[33]);
        Qh[40] = function(...)
            v5 = pcall;
            j = v5(function(...)
                local F = {
                    F[1],
                    F[2],
                    F[3]
                };
                return A[F[1]].PlayerGui.MainGUI.Game.CoinBags.Container.Coin.CurrencyFrame.Icon.Coins.Text; 
            end);
            if j then
                v4 = pcall;
                H = tonumber(H[2]) or 0;
            end;
            v5 = v5;
            return j or 0; 
        end;
        Qh[28] = Qh[29][Qh[31]];
        Qh[26] = Qh[27][Qh[28]];
        Qh[28] = r15;
        Qh[32] = 14581029624453;
        Qh[31] = "\xc9\xdb\xfc\x8ce";
        Qh[29] = r16;
        Qh[30] = Qh[29](Qh[31], Qh[32]);
        Qh[31] = "Enum";
        Qh[27] = Qh[28][Qh[30]];
        Qh[30] = Env[Qh[31]];
        Qh[32] = r15;
        Qh[33] = r16;
        Qh[34] = Qh[33](Qh[35], Qh[36]);
        Qh[31] = Qh[32][Qh[34]];
        Qh[29] = Qh[30][Qh[31]];
        Qh[31] = r15;
        Qh[35] = 22040538884119;
        Qh[32] = r16;
        Qh[34] = "`\xe4\x84Z";
        Qh[33] = Qh[32](Qh[34], Qh[35]);
        Qh[30] = Qh[31][Qh[33]];
        Qh[28] = Qh[29][Qh[30]];
        Qh[30] = r15;
        Qh[34] = 16316997639598;
        Qh[33] = "\x12\x0f\x9d_";
        Qh[31] = r16;
        Qh[32] = Qh[31](Qh[33], Qh[34]);
        Qh[29] = Qh[30][Qh[32]];
        Qh[33] = "Enum";
        Qh[32] = Env[Qh[33]];
        Qh[34] = r15;
        Qh[35] = r16;
        Qh[36] = Qh[35](Qh[37], Qh[38]);
        Qh[33] = Qh[34][Qh[36]];
        Qh[31] = Qh[32][Qh[33]];
        Qh[33] = r15;
        Qh[37] = 27561249796642;
        Qh[36] = "\xa3\x018=G\xcc\xc0Lf\xbc";
        Qh[34] = r16;
        Qh[35] = Qh[34](Qh[36], Qh[37]);
        Qh[32] = Qh[33][Qh[35]];
        Qh[30] = Qh[31][Qh[32]];
        Qh[36] = 7971447688831;
        Qh[32] = r15;
        Qh[33] = r16;
        Qh[35] = ". \x1eB]!\x16\xb38\xb0";
        Qh[34] = Qh[33](Qh[35], Qh[36]);
        Qh[31] = Qh[32][Qh[34]];
        Qh[12] = {
            [Qh[14]] = Qh[15],
            [Qh[16]] = Qh[17],
            [Qh[18]] = Qh[19],
            [Qh[20]] = Qh[21],
            [Qh[22]] = Qh[23],
            [Qh[24]] = Qh[25],
            [Qh[26]] = Qh[27],
            [Qh[28]] = Qh[29],
            [Qh[30]] = Qh[31]
        };
        Qh[23] = 22580335012114;
        Qh[18] = "Enum";
        Qh[22] = "\xc2&\xe9C5\xdb{\xc1";
        Qh[14] = 50;
        A[Qh[14]] = Qh[12];
        Qh[17] = Env[Qh[18]];
        Qh[19] = r15;
        Qh[20] = r16;
        Qh[30] = "\xd0g0\xe4\xd2\x8fkc";
        Qh[21] = Qh[20](Qh[22], Qh[23]);
        Qh[18] = Qh[19][Qh[21]];
        Qh[16] = Qh[17][Qh[18]];
        Qh[18] = r15;
        Qh[29] = 797646029171;
        Qh[21] = "q\x9a\x91\x08n";
        Qh[22] = 28014273032949;
        Qh[19] = r16;
        Qh[20] = Qh[19](Qh[21], Qh[22]);
        Qh[17] = Qh[18][Qh[20]];
        Qh[22] = "\xb3\xf5\xfc\xe14J\xb0";
        Qh[15] = Qh[16][Qh[17]];
        Qh[18] = "Color3";
        Qh[23] = 7975028280961;
        Qh[17] = Env[Qh[18]];
        Qh[19] = r15;
        Qh[25] = 16705213455970;
        Qh[24] = "N\xd8\xe2\xcf\xeeb\xd7~";
        Qh[20] = r16;
        Qh[21] = Qh[20](Qh[22], Qh[23]);
        Qh[20] = 64;
        Qh[18] = Qh[19][Qh[21]];
        Qh[19] = 170;
        Qh[16] = Qh[17][Qh[18]];
        Qh[18] = 106;
        Qh[17] = Qh[16](Qh[18], Qh[19], Qh[20]);
        Qh[20] = "Enum";
        Qh[19] = Env[Qh[20]];
        Qh[21] = r15;
        Qh[22] = r16;
        Qh[27] = 11360463639722;
        Qh[23] = Qh[22](Qh[24], Qh[25]);
        Qh[20] = Qh[21][Qh[23]];
        Qh[18] = Qh[19][Qh[20]];
        Qh[32] = "Bf\x0b\xb3m\x1fK7";
        Qh[20] = r15;
        Qh[21] = r16;
        Qh[23] = "\x11\x9d\xe6\x14Y\xea";
        Qh[24] = 11665038759223;
        Qh[22] = Qh[21](Qh[23], Qh[24]);
        Qh[26] = "\xdf=\xa3\x94\x0fK `";
        Qh[24] = "\xe5%\xd8\xf3\xfe\x18K";
        Qh[19] = Qh[20][Qh[22]];
        Qh[16] = Qh[18][Qh[19]];
        Qh[25] = 33994746035670;
        Qh[28] = "\xf3\xe3\x94\x07\x04\xa6$Z";
        Qh[20] = "Color3";
        Qh[19] = Env[Qh[20]];
        Qh[21] = r15;
        Qh[22] = r16;
        Qh[23] = Qh[22](Qh[24], Qh[25]);
        Qh[20] = Qh[21][Qh[23]];
        Qh[18] = Qh[19][Qh[20]];
        Qh[22] = 67;
        Qh[21] = 96;
        Qh[20] = 134;
        Qh[19] = Qh[18](Qh[20], Qh[21], Qh[22]);
        Qh[22] = "Enum";
        Qh[21] = Env[Qh[22]];
        Qh[23] = r15;
        Qh[24] = r16;
        Qh[25] = Qh[24](Qh[26], Qh[27]);
        Qh[22] = Qh[23][Qh[25]];
        Qh[20] = Qh[21][Qh[22]];
        Qh[26] = 27077298368832;
        Qh[25] = "\xab\x15'";
        Qh[22] = r15;
        Qh[27] = 5229256198531;
        Qh[23] = r16;
        Qh[24] = Qh[23](Qh[25], Qh[26]);
        Qh[26] = "+\xd4\xe6\x08_`\x16";
        Qh[21] = Qh[22][Qh[24]];
        Qh[18] = Qh[20][Qh[21]];
        Qh[66] = 2317580239927;
        Qh[22] = "Color3";
        Qh[21] = Env[Qh[22]];
        Qh[23] = r15;
        Qh[24] = r16;
        Qh[50] = 51;
        Qh[25] = Qh[24](Qh[26], Qh[27]);
        Qh[22] = Qh[23][Qh[25]];
        Qh[20] = Qh[21][Qh[22]];
        Qh[37] = 4037986174808;
        Qh[22] = 102;
        Qh[24] = 51;
        Qh[23] = 76;
        Qh[33] = 1120545227273;
        Qh[38] = 52;
        Qh[21] = Qh[20](Qh[22], Qh[23], Qh[24]);
        Qh[24] = "Enum";
        Qh[23] = Env[Qh[24]];
        Qh[25] = r15;
        Qh[26] = r16;
        Qh[27] = Qh[26](Qh[28], Qh[29]);
        Qh[28] = 14181025126859;
        Qh[24] = Qh[25][Qh[27]];
        Qh[22] = Qh[23][Qh[24]];
        Qh[27] = "\xd9\xfb\x00v";
        Qh[24] = r15;
        Qh[29] = 22163893954640;
        Qh[25] = r16;
        Qh[26] = Qh[25](Qh[27], Qh[28]);
        Qh[34] = "]\xab\x1e\xd35\xb4\x96(";
        Qh[23] = Qh[24][Qh[26]];
        Qh[20] = Qh[22][Qh[23]];
        Qh[24] = "Color3";
        Qh[23] = Env[Qh[24]];
        Qh[25] = r15;
        Qh[28] = "\xb1r\xb3\xcb\x8ek\xfe";
        Qh[26] = r16;
        Qh[36] = "\xb8\xb0@\x84p\xaf\x15\xda";
        Qh[27] = Qh[26](Qh[28], Qh[29]);
        Qh[24] = Qh[25][Qh[27]];
        Qh[22] = Qh[23][Qh[24]];
        Qh[31] = 28027373269755;
        Qh[24] = 219;
        Qh[26] = 160;
        Qh[25] = 211;
        Qh[23] = Qh[22](Qh[24], Qh[25], Qh[26]);
        Qh[26] = "Enum";
        Qh[25] = Env[Qh[26]];
        Qh[27] = r15;
        Qh[28] = r16;
        Qh[29] = Qh[28](Qh[30], Qh[31]);
        Qh[26] = Qh[27][Qh[29]];
        Qh[24] = Qh[25][Qh[26]];
        Qh[29] = "\x84<e&";
        Qh[26] = r15;
        Qh[30] = 33132883557444;
        Qh[35] = 5782898444932;
        Qh[27] = r16;
        Qh[28] = Qh[27](Qh[29], Qh[30]);
        Qh[30] = "\xb1E[3\x99{\xe9";
        Qh[25] = Qh[26][Qh[28]];
        Qh[22] = Qh[24][Qh[25]];
        Qh[26] = "Color3";
        Qh[31] = 5730780138092;
        Qh[25] = Env[Qh[26]];
        Qh[27] = r15;
        Qh[28] = r16;
        Qh[29] = Qh[28](Qh[30], Qh[31]);
        Qh[26] = Qh[27][Qh[29]];
        Qh[28] = 122;
        Qh[24] = Qh[25][Qh[26]];
        Qh[27] = 122;
        Qh[26] = 122;
        Qh[25] = Qh[24](Qh[26], Qh[27], Qh[28]);
        Qh[28] = "Enum";
        Qh[27] = Env[Qh[28]];
        Qh[29] = r15;
        Qh[30] = r16;
        Qh[31] = Qh[30](Qh[32], Qh[33]);
        Qh[28] = Qh[29][Qh[31]];
        Qh[26] = Qh[27][Qh[28]];
        Qh[31] = "~\xfe\xc7\xc2\xa1";
        Qh[32] = 21229836330653;
        Qh[28] = r15;
        Qh[29] = r16;
        Qh[30] = Qh[29](Qh[31], Qh[32]);
        Qh[27] = Qh[28][Qh[30]];
        Qh[32] = "^\xd7U.\xe5\xd7a";
        Qh[28] = "Color3";
        Qh[24] = Qh[26][Qh[27]];
        Qh[27] = Env[Qh[28]];
        Qh[29] = r15;
        Qh[30] = r16;
        Qh[33] = 30369137489725;
        Qh[31] = Qh[30](Qh[32], Qh[33]);
        Qh[28] = Qh[29][Qh[31]];
        Qh[30] = 90;
        Qh[29] = 90;
        Qh[26] = Qh[27][Qh[28]];
        Qh[28] = 90;
        Qh[27] = Qh[26](Qh[28], Qh[29], Qh[30]);
        Qh[69] = 29436476487051;
        Qh[30] = "Enum";
        Qh[29] = Env[Qh[30]];
        Qh[31] = r15;
        Qh[32] = r16;
        Qh[33] = Qh[32](Qh[34], Qh[35]);
        Qh[30] = Qh[31][Qh[33]];
        Qh[28] = Qh[29][Qh[30]];
        Qh[33] = "\xf3\xd3\x91\xa9";
        Qh[30] = r15;
        Qh[35] = 4793914198200;
        Qh[31] = r16;
        Qh[34] = 17847387185270;
        Qh[32] = Qh[31](Qh[33], Qh[34]);
        Qh[29] = Qh[30][Qh[32]];
        Qh[26] = Qh[28][Qh[29]];
        Qh[34] = "\xbba\x8c\xa2\\0\xcc";
        Qh[30] = "Color3";
        Qh[29] = Env[Qh[30]];
        Qh[31] = r15;
        Qh[32] = r16;
        Qh[33] = Qh[32](Qh[34], Qh[35]);
        Qh[30] = Qh[31][Qh[33]];
        Qh[28] = Qh[29][Qh[30]];
        Qh[31] = 245;
        Qh[32] = 245;
        Qh[30] = 245;
        Qh[29] = Qh[28](Qh[30], Qh[31], Qh[32]);
        Qh[32] = "Enum";
        Qh[31] = Env[Qh[32]];
        Qh[33] = r15;
        Qh[34] = r16;
        Qh[35] = Qh[34](Qh[36], Qh[37]);
        Qh[32] = Qh[33][Qh[35]];
        Qh[36] = 22672718768445;
        Qh[30] = Qh[31][Qh[32]];
        Qh[32] = r15;
        Qh[33] = r16;
        Qh[35] = "0 ^\x82\t";
        Qh[34] = Qh[33](Qh[35], Qh[36]);
        Qh[31] = Qh[32][Qh[34]];
        Qh[36] = "1\x85\xb5\xe8\x0e\xb8?";
        Qh[37] = 8912908963894;
        Qh[32] = "Color3";
        Qh[28] = Qh[30][Qh[31]];
        Qh[31] = Env[Qh[32]];
        Qh[33] = r15;
        Qh[34] = r16;
        Qh[35] = Qh[34](Qh[36], Qh[37]);
        Qh[32] = Qh[33][Qh[35]];
        Qh[35] = function(...)
            if r43.FovCircle then
                pcall(function(...)
                    v5 = r43.FovCircle;
                    v5.Remove(v5);
                    return; 
                end);
            end;
            v1 = Drawing.new("Circle");
            v1.Radius = r42.FovRadius;
            v1.Color = r44.White;
            v1.Thickness = 1.5;
            v1.Transparency = .7;
            v1.Filled = false;
            v1.Visible = false;
            v1.NumSides = 64;
            r43.FovCircle = v1;
            return; 
        end;
        Qh[30] = Qh[31][Qh[32]];
        Qh[34] = 228;
        Qh[32] = 63;
        Qh[33] = 118;
        Qh[31] = Qh[30](Qh[32], Qh[33], Qh[34]);
        Qh[12] = {
            [Qh[15]] = Qh[17],
            [Qh[16]] = Qh[19],
            [Qh[18]] = Qh[21],
            [Qh[20]] = Qh[23],
            [Qh[22]] = Qh[25],
            [Qh[24]] = Qh[27],
            [Qh[26]] = Qh[29],
            [Qh[28]] = Qh[31]
        };
        Qh[15] = 53;
        Qh[16] = function(...)
            e = r16("\xecC\x94\xcb\nH\xec'b\x98\xd5GCQ\x91\x9e\xca\xa9\xe4\xd2", 18619015799262);
            if r43[r15[e]] then
                return;
            end;
            H = A[Qh[13]];
            v1 = e[2];
            j = e[3];
            for j, Q in pairs(v3) do
                r144 = Q;
                Q = 37;
                v5 = r31;
                r145 = v5.FindFirstChild(v5, j);
                if not r145 then
                    r145 = Instance.new("MaterialVariant");
                    y = j;
                    r145.Name = y;
                    r145.Parent = r31;
                end;
                pcall(function(...)
                    r145.BaseMaterial = r144.BaseMaterial;
                    r145.ColorMap = r144.Texture;
                    r145.MetalnessMap = r144.Texture;
                    r145.NormalMap = r144.Texture;
                    r145.RoughnessMap = r144.Texture;
                    r145.MaterialPattern = Enum.MaterialPattern.Regular;
                    r145.StudsPerTile = 5;
                    return; 
                end); 
            end;
            r43.TextureVariantsBuilt = true;
            return; 
        end;
        Qh[24] = "math";
        Qh[28] = "E2";
        Qh[18] = function(arg1_56, ...)
            v1 = arg1_56;
            if not v1.IsDescendantOf(v1, workspace) then
                return true;
            end;
            if v1.Name == "LarpticWeather" or v1.Name == "Part" then
                return true;
            end;
            j = v1.Parent;
            if j then
                v3 = j.IsA(j, "Tool") or j.IsA(j, "Accessory");
                v5 = v1[r15[e]];
            end;
            if j then
                return true;
            end;
            e = r16;
            H = v1.FindFirstAncestorOfClass(v1, "Model");
            if H then
                e = game.Players;
                v3 = e.GetPlayerFromCharacter(e, H);
            end;
            if H then
                return true;
            end;
            return false; 
        end;
        A[Qh[15]] = Qh[12];
        Qh[12] = 54;
        A[Qh[12]] = Qh[16];
        Qh[17] = function(arg1_57, ...)
            v1 = arg1_57;
            if not r43.TextureState[v1] then
                r43.TextureState[v1] = {
                    ["Color"] = v1.Color,
                    ["Material"] = v1.Material,
                    ["MaterialVariant"] = v1.MaterialVariant
                };
            end;
            return r43.TextureState[v1]; 
        end;
        Qh[31] = function(...)
            H = r16;
            if r42.XRayEnabled then
                H = r26;
                j = H[3];
                H = H[1];
                for j, Q in H, ipairs(H.GetDescendants(H)) do
                    e = j;
                    if Q.IsA(Q, "BasePart") and not Q.IsA(Q, "Terrain") then
                        r43.XRayParts[Q] = Q.LocalTransparencyModifier;
                        Q.LocalTransparencyModifier = .6;
                    end; 
                end;
            else
                Q = r43;
                v2 = r15;
                j = Q[2];
                H = Q[3];
                for H, Q in pairs(Q.XRayParts) do
                    r146 = H;
                    r147 = Q;
                    v2 = r146;
                    Q = 23;
                    if v2 then
                        v4 = r146.Parent;
                    end;
                    if v2 then
                        pcall(function(...)
                            r146.LocalTransparencyModifier = A[v5];
                            return; 
                        end);
                    end; 
                end;
                r43.XRayParts = {};
                return;
            end; 
        end;
        Qh[37] = function(arg1_58, ...)
            v1 = arg1_58;
            if not r34.Character then
                return;
            end;
            v5 = r34.Character;
            j = v5.FindFirstChild(v5, "HumanoidRootPart");
            if not j then
                return;
            end;
            e = math.huge;
            v2 = r24;
            v7 = {
                v2.GetPlayers(v2)
            };
            v2 = {
                ipairs(C(v7))
            };
            Q = v2[2];
            v4 = v2[3];
            v2 = ipairs(C(v7));
            v4, y = v2(Q, v4);
            if v4 then
                v4 = v3;
                v5 = {
                    v2.GetPlayers(v2)
                };
            end;
            if not nil then
                y = r16;
                r38("\xd0\xa2\xd0\xb5\xd0\xbb\xd0\xb5\xd0\xbf\xd0\xbe\xd1\x80\xd1\x82", v1 .. " \xd0\xbd\xd0\xb5 \xd0\xbd\xd0\xb0\xd0\xb9\xd0\xb4\xd0\xb5\xd0\xbd", 2);
                return;
            end;
            y = r16("\x1b\xe7\x16\xd6=\x9dna\x83", 2109787227094);
            Q = nil[r15[y]];
            v4 = Q.FindFirstChild(Q, "HumanoidRootPart");
            if v4 then
                j.CFrame = v4.CFrame * CFrame.new(0, 3, 2);
                r38("\xd0\xa2\xd0\xb5\xd0\xbb\xd0\xb5\xd0\xbf\xd0\xbe\xd1\x80\xd1\x82", "\xd0\xa2\xd0\xb5\xd0\xbb\xd0\xb5\xd0\xbf\xd0\xbe\xd1\x80\xd1\x82 \xd0\xba " .. v1, 2);
            end;
            return; 
        end;
        Qh[16] = 55;
        A[Qh[16]] = Qh[17];
        Qh[17] = 56;
        Qh[19] = function(...)
            v2 = 8927103111229;
            if not r42[r15[r16("\x86).\\\x8f\xb7\xfdUh\xb3\xaa\xd1\x87\x0cZr\xf5\x88", v2)]] then
                return;
            end;
            A[Qh[12]]();
            H = workspace;
            j = H[3];
            H = H[1];
            for j, Q in H, ipairs(H.GetDescendants(H)) do
                r148 = Q;
                e = j;
                v2 = A[v5];
                v7 = v2.IsA(v2, "BasePart");
                if v7 then
                    v4 = not A[Qh[17]](A[v5]);
                end;
                if v7 then
                    A[Qh[16]](A[v5]);
                    r149 = A[Qh[14]][A[v5].Material];
                    if r149 then
                        pcall(function(...)
                            A[v5].MaterialVariant = r149;
                            return; 
                        end);
                    end;
                end; 
            end;
            v5 = workspace;
            r150 = v5.FindFirstChildOfClass(v5, "Terrain");
            if r150 then
                e = v4[3];
                for e, v4 in v4[1], pairs(A[Qh[15]]) do
                    r151 = e;
                    r152 = v4;
                    pcall(function(...)
                        v5 = r150;
                        v5.SetMaterialColor(v5, r151, r152);
                        return; 
                    end); 
                end;
            end;
            return; 
        end;
        Qh[20] = function(...)
            e = r43;
            H = e.TextureState;
            v1 = e[2];
            H = e[1];
            for j, Q in pairs(H) do
                r153 = j;
                r154 = Q;
                if r153 and (r153.Parent and A[v5]) then
                    pcall(function(...)
                        r153.Color = A[v5].Color;
                        r153.Material = A[v5].Material;
                        r153.MaterialVariant = A[v5].MaterialVariant or "";
                        return; 
                    end);
                end; 
            end;
            r43.TextureState = {};
            v5 = pairs;
            v1 = ("g\xd8w\xf4X7\xda6\xa7\xed\xc5\x05")[1];
            j = ("g\xd8w\xf4X7\xda6\xa7\xed\xc5\x05")[2];
            for H, Q in v5(A[Qh[13]]) do
                v5 = r31;
                r155 = v5.FindFirstChild(v5, H);
                v7 = r155;
                if v7 then
                    v7 = r155;
                    v4 = v7.IsA(v7, "MaterialVariant");
                end;
                if v7 then
                    pcall(function(...)
                        v5 = r155;
                        v5.Destroy(v5);
                        return; 
                    end);
                end; 
            end;
            r43.TextureVariantsBuilt = false;
            return; 
        end;
        Qh[29] = 461760577751;
        A[Qh[17]] = Qh[18];
        Qh[18] = 57;
        A[Qh[18]] = Qh[19];
        Qh[19] = 58;
        A[Qh[19]] = Qh[20];
        Qh[21] = function(arg1_59, ...)
            v1 = arg1_59;
            r42.TexturePackEnabled = v1;
            if v1 then
                A[Qh[18]]();
                r38("Texture Pack", "\xd0\x92\xd0\xba\xd0\xbb\xd1\x8e\xd1\x87\xd0\xb5\xd0\xbd", 2);
            else
                A[Qh[19]]();
                r38("Texture Pack", "\xd0\x92\xd1\x8b\xd0\xba\xd0\xbb\xd1\x8e\xd1\x87\xd0\xb5\xd0\xbd", 2);
            end;
            return; 
        end;
        Qh[48] = function(...)
            r45(A[Qh[46]]);
            A[Qh[46]] = nil;
            r45(A[Qh[47]]);
            A[Qh[47]] = nil;
            return; 
        end;
        Qh[20] = 59;
        A[Qh[20]] = Qh[21];
        Qh[23] = Env[Qh[24]];
        Qh[25] = r15;
        Qh[26] = r16;
        Qh[27] = Qh[26](Qh[28], Qh[29]);
        Qh[26] = function(...)
            e = r43;
            H = e.ChinaHatParts;
            j = e[3];
            v1 = e[2];
            for j, Q in pairs("pairs") do
                if Q then
                    v4 = Q.Parent and j == r34.Character;
                    v5 = Env[v3];
                end;
                if Q then
                    Q.Transparency = r42.ChinaHatTransparency;
                    Q.Reflectance = r42.ChinaHatReflectance;
                    if r42.ChinaHatRainbow then
                        Q.Color = Color3.fromHSV(tick() % r42.ChinaHatRainbowSpeed / r42.ChinaHatRainbowSpeed, 1, 1);
                    else
                        Q.Color = r42.ChinaHatColor;
                    end;
                    v4 = Q.FindFirstChildOfClass(Q, "SpecialMesh");
                    if v4 then
                        v4.Scale = Vector3.new(r42.ChinaHatRadius, r42.ChinaHatHeight, r42.ChinaHatRadius);
                    end;
                end; 
            end;
            return; 
        end;
        Qh[24] = Qh[25][Qh[27]];
        Qh[22] = Qh[23][Qh[24]];
        Qh[34] = function(...)
            Vector2.new(r35.ViewportSize.v2 / 2, r35.ViewportSize.v3 / 2);
            H = math.huge;
            v4 = r24;
            e = v4[2];
            v4 = v4[1];
            for Q, v7 in ipairs(v4.GetPlayers(v4)) do
                v2 = Q;
                if v7 == r34 then
                    
                else
                    if not r47(v7) then
                        
                    else
                        if not v7.Character then
                            
                        else
                            v5 = v7.Character;
                            J = r16;
                            y = v5.FindFirstChild(v5, "HumanoidRootPart");
                            v5 = not y;
                            if v5 then
                                
                            else
                                v5 = r35;
                                J = {
                                    v5.WorldToScreenPoint(v5, y.Position)
                                };
                                if not J[2] or v5.WorldToScreenPoint(v5, y.Position).Z < 0 then
                                    
                                else
                                    v5 = (Vector2.new(r35.ViewportSize.v2 / 2, r35[r15[r16("\xf3\xd6*\x93\xf5\xeb+\t\xb0!w)", v6)]][r15[r16(y, w)]] / 2) - Vector2.new(w.v2, w.v3)).Magnitude;
                                    if v5 <= r42.FovRadius and v5 < math.huge then
                                        v5 = v5;
                                        H = v5;
                                        j = v7;
                                    end;
                                end;
                            end;
                        end;
                    end;
                end; 
            end;
            return nil; 
        end;
        Qh[23] = 2;
        Qh[27] = 60;
        Qh[21] = Qh[22] * Qh[23];
        Qh[22] = 61;
        A[Qh[22]] = Qh[21];
        Qh[21] = 62;
        Qh[23] = function(...)
            for m = 1, #r43.ChinaHatDrawings do
                r156 = v1;
                pcall(function(...)
                    v5 = r43.ChinaHatDrawings[r156][1];
                    v5.Remove(v5);
                    v5 = r43.ChinaHatDrawings[r156][2];
                    v5.Remove(v5);
                    return; 
                end); 
            end;
            r43.ChinaHatDrawings = {};
            for m = 1, r42.ChinaHatSides do
                r43.ChinaHatDrawings[v1] = {
                    Drawing.new("Line"),
                    Drawing.new("Triangle")
                };
                r43.ChinaHatDrawings[v1][1].ZIndex = 2;
                r43.ChinaHatDrawings[v1][1].Thickness = 2;
                r43.ChinaHatDrawings[v1][2].ZIndex = 1;
                r43.ChinaHatDrawings[v1][2].Filled = true; 
            end;
            return; 
        end;
        Qh[39] = function(...)
            r45(A[Qh[38]]);
            A[Qh[38]] = nil;
            if not r42.AntiAFKEnabled then
                return;
            end;
            r157 = 0;
            v3 = r25.Heartbeat;
            A[Qh[38]] = v3.Connect(v3, function(...)
                if not r34.Character then
                    return;
                end;
                v5 = tick() - r157 > 60;
                if v5 then
                    v5 = r34.Character;
                    j = v5.FindFirstChildOfClass(v5, "Humanoid");
                    if j then
                        j.Jump = true;
                        r157 = tick();
                    end;
                end;
                return; 
            end);
            return; 
        end;
        Qh[29] = function(arg1_60, ...)
            v1 = arg1_60;
            H = arg1_60;
            r42.ChinaHatStyle = H;
            if r42.ChinaHatEnabled then
                A[Qh[27]](false);
                task.wait(.1);
                A[Qh[27]](true);
            end;
            r38("China Hat", "\xd0\xa1\xd1\x82\xd0\xb8\xd0\xbb\xd1\x8c: " .. v1, 2);
            return; 
        end;
        Qh[24] = function(...)
            if r43.ChinaHatParts[r34.Character] then
                pcall(function(...)
                    v5 = r43.ChinaHatParts[r34.Character];
                    v5.Destroy(v5);
                    return; 
                end);
                r43.ChinaHatParts[r34.Character] = nil;
            end;
            return; 
        end;
        A[Qh[21]] = Qh[23];
        Qh[23] = 63;
        A[Qh[23]] = Qh[24];
        Qh[24] = 64;
        Qh[32] = function(arg1_61, ...)
            v1 = arg1_61;
            r158 = Vector3.new(v1.v2, r54(v1) + .08, v1.Z);
            r159 = Instance.new("Part");
            r159.Shape = Enum.PartType.Cylinder;
            r159.Size = Vector3.new(.08, 0.5, 0.5);
            r159.Material = Enum.Material.Neon;
            r159.Color = r44.Purple;
            r159.Transparency = 0;
            r159.Anchored = true;
            r159.CanCollide = false;
            r159.CastShadow = false;
            r159.CFrame = CFrame.new(r158) * CFrame.Angles(0, 0, math.rad(90));
            r159.Parent = r26;
            r160 = Instance.new("PointLight");
            r160.Brightness = 4;
            r160.Color = r44.Purple;
            r160.Range = 20;
            r160.Parent = r159;
            r161 = tick();
            r162 = .7;
            v5 = r25.Heartbeat;
            r163 = v5.Connect(v5, function(...)
                if not r159 or not r159.Parent then
                    r45(r163);
                    return;
                end;
                v1 = (tick() - r161) / r162;
                if v1 >= 1 then
                    pcall(function(...)
                        v5 = A[e];
                        v5.Destroy(v5);
                        return; 
                    end);
                    r45(r163);
                    return;
                end;
                j = 0.5 + v1 * 6;
                r159.Size = Vector3.new(.08, j, j);
                r159.Transparency = v1;
                r159.CFrame = CFrame.new(r158) * CFrame.Angles(0, 0, math.rad(90));
                r160.Brightness = 4 * (1 - v1);
                return; 
            end);
            return; 
        end;
        Qh[25] = function(arg1_62, ...)
            v1 = arg1_62;
            task.wait(.1);
            j = v1.WaitForChild(v1, "Head", 5);
            if not j then
                return;
            end;
            A[Qh[23]]();
            H = Instance.new("Part");
            H.Name = "ChineseHat";
            H.Transparency = r42.ChinaHatTransparency;
            H.Color = r42.ChinaHatColor;
            H.Material = Enum.Material.Neon;
            H.CanCollide = false;
            H.Reflectance = r42.ChinaHatReflectance;
            e = Instance.new("SpecialMesh");
            e.MeshId = "rbxassetid://1033714";
            e.Scale = Vector3.new(r42.ChinaHatRadius, r42.ChinaHatHeight, r42.ChinaHatRadius);
            e.Parent = H;
            Q = Instance.new("WeldConstraint");
            Q.Part0 = j;
            Q.Part1 = H;
            Q.Parent = H;
            H.CFrame = j.CFrame * CFrame.new(0, 1.1, 0);
            H.Parent = v1;
            r43.ChinaHatParts[v1] = H;
            return; 
        end;
        Qh[30] = function(...)
            r45(r43.RGBConnection);
            r43.RGBConnection = nil;
            if not r42.RGBHumanoid then
                H = r16;
                if r34.Character then
                    H = r34.Character;
                    j = H[3];
                    H = H[1];
                    for j, Q in H, ipairs(H.GetDescendants(H)) do
                        e = j;
                        if Q.IsA(Q, "BasePart") then
                            Q.Material = Enum.Material.Plastic;
                            Q.Color = Color3.fromRGB(255, 255, 255);
                            Q.Transparency = 0;
                        end; 
                    end;
                end;
                return;
            end;
            j = r25.Heartbeat;
            r43.RGBConnection = j.Connect(j, function(...)
                if not r34.Character then
                    return;
                end;
                Color3.fromHSV(tick() % 1, 1, 1);
                e = r34.Character;
                j = e[2];
                e = e[1];
                for H, v4 in ipairs(e.GetDescendants(e)) do
                    Q = H;
                    if v4.IsA(v4, "BasePart") and v4.Name ~= "HumanoidRootPart" then
                        v4.Material = Enum.Material.ForceField;
                        v2 = Color3.fromHSV(tick() % 1, 1, 1);
                        v4.Color = v2;
                        v4.Transparency = .3;
                    end; 
                end;
                return; 
            end);
            return; 
        end;
        A[Qh[24]] = Qh[25];
        Qh[25] = 65;
        Qh[28] = function(arg1_63, ...)
            v1 = arg1_63;
            r42.ChinaHatEnabled = v1;
            if v1 then
                A[Qh[21]]();
                if r42.ChinaHatStyle == "Classic" and r34.Character then
                    A[Qh[24]](r34.Character);
                end;
                if r43.ChinaHatConnection then
                    r45(r43.ChinaHatConnection);
                end;
                j = r25.Heartbeat;
                r43.ChinaHatConnection = j.Connect(j, function(...)
                    if r42.ChinaHatStyle == "Classic" then
                        A[Qh[25]]();
                    end;
                    return; 
                end);
                r38("China Hat", "\xd0\x92\xd0\xba\xd0\xbb\xd1\x8e\xd1\x87\xd0\xb5\xd0\xbd (" .. r42.ChinaHatStyle .. ")", 2);
            else
                A[Qh[23]]();
                for j = 1, #r43.ChinaHatDrawings do
                    r164 = j;
                    pcall(function(...)
                        r43.ChinaHatDrawings[r164][1].Visible = false;
                        r43.ChinaHatDrawings[r164][2].Visible = false;
                        return; 
                    end); 
                end;
                if r43.ChinaHatConnection then
                    r45(r43.ChinaHatConnection);
                    r43.ChinaHatConnection = nil;
                end;
                r38("China Hat", "\xd0\x92\xd1\x8b\xd0\xba\xd0\xbb\xd1\x8e\xd1\x87\xd0\xb5\xd0\xbd", 2);
                return;
            end; 
        end;
        A[Qh[25]] = Qh[26];
        A[Qh[27]] = Qh[28];
        Qh[26] = function(...)
            v4 = r16("\xeej\x1f\xfdy\x08\x11\x15\x10\xea\xf18\x9d\x82f", 15754342784168);
            for j = 1, #r43.ChinaHatDrawings do
                v7 = r43.ChinaHatDrawings[j][2];
                v2 = r43.ChinaHatDrawings[j][1];
                if r42[r15[v4]] and (r34.Character and (v4.FindFirstChild(v4, "Head") ~= nil and ((r35.CFrame.p - r35.Focus.p).magnitude > 1 and r34.Character.Humanoid.Health > 0))) then
                    if r42.ChinaHatRainbow then
                        y = Color3.fromHSV((tick() % r42.ChinaHatRainbowSpeed / r42.ChinaHatRainbowSpeed - j / #r43.ChinaHatDrawings) % 1, 0.5, 1);
                    else
                        y = r42.ChinaHatColor;
                    end;
                    w = r34.Character.Head.Position + Vector3.new(0, 0.75, 0);
                    P = j / r42.ChinaHatSides * A[Qh[22]];
                    v8 = (j + 1) / r42.ChinaHatSides * A[Qh[22]];
                    J = r35;
                    q = J.WorldToViewportPoint(J, w + Vector3.new(math.cos(P), 0, math.sin(P)) * r42.ChinaHatRadius);
                    J = r35;
                    k = J.WorldToViewportPoint(J, w + Vector3.new(math.cos(v8), 0, math.sin(v8)) * r42.ChinaHatRadius);
                    J = r35;
                    i = J.WorldToViewportPoint(J, w + Vector3.new(0, 0.75, 0));
                    v2.From = Vector2.new(q.v2, q.v3);
                    v2.To = Vector2.new(k.v2, k.v3);
                    v2.Color = T;
                    v2.Transparency = 1 - r42.ChinaHatTransparency;
                    v2.Visible = true;
                    v7.PointA = Vector2.new(i.v2, i.v3);
                    v7.PointB = v2.From;
                    v7.PointC = v2.To;
                    v7.Color = y;
                    v7.Transparency = .35;
                    v7.Visible = true;
                else
                    v2.Visible = false;
                    v7.Visible = false;
                end; 
            end;
            return; 
        end;
        Qh[28] = 66;
        A[Qh[28]] = Qh[29];
        Qh[29] = 67;
        A[Qh[29]] = Qh[30];
        Qh[30] = 68;
        A[Qh[30]] = Qh[31];
        Qh[31] = 69;
        Qh[33] = function(...)
            if not r42.JumpCircles or not r34.Character then
                return;
            end;
            v5 = r34.Character;
            v1 = v5.FindFirstChildOfClass(v5, "Humanoid");
            v5 = r34.Character;
            j = v5.FindFirstChild(v5, "HumanoidRootPart");
            if not v1 or not j then
                return;
            end;
            H = v1.GetState(v1) == Enum.HumanoidStateType.Jumping;
            if H then
                v3 = not r43.JumpTracking.wasJumping;
            end;
            if H then
                A[Qh[31]](j.Position);
            end;
            r43.JumpTracking.wasJumping = H;
            return; 
        end;
        A[Qh[31]] = Qh[32];
        Qh[32] = 70;
        Qh[63] = 21068873983570;
        A[Qh[32]] = Qh[33];
        Qh[33] = 71;
        A[Qh[33]] = Qh[34];
        Qh[34] = 72;
        A[Qh[34]] = Qh[35];
        Qh[36] = function(...)
            r45(r43.FovConnection);
            r43.FovConnection = nil;
            if r43.FovCircle then
                r43.FovCircle.Visible = false;
            end;
            if not r42.FovAimbotEnabled then
                return;
            end;
            if not r43.FovCircle then
                A[Qh[34]]();
            end;
            r165 = r43.FovCircle;
            j = r25.RenderStepped;
            r43.FovConnection = j.Connect(j, function(...)
                if not r42.FovAimbotEnabled then
                    r165.Visible = false;
                    return;
                end;
                j = Vector2.new(r35.ViewportSize.v2 / 2, r35.ViewportSize.v3 / 2);
                r165.Position = j;
                r165.Radius = r42.FovRadius;
                r165.Visible = true;
                v5 = A[Qh[33]];
                j = v5();
                if j then
                    r165.Color = r44.Red;
                    r165.Thickness = 2;
                    v5 = j.Character;
                    H = v5.FindFirstChild(v5, "HumanoidRootPart");
                    if H then
                        r35.CFrame = CFrame.lookAt(r35.CFrame.Position, H.Position, r35.CFrame.UpVector);
                    end;
                else
                    r165.Color = r44.White;
                    r165.Thickness = 1.5;
                end;
                return; 
            end);
            return; 
        end;
        Qh[35] = 73;
        A[Qh[35]] = Qh[36];
        Qh[36] = 74;
        A[Qh[36]] = Qh[37];
        Qh[37] = nil;
        A[Qh[38]] = Qh[37];
        Qh[37] = 75;
        A[Qh[37]] = Qh[39];
        Qh[39] = 76;
        A[Qh[39]] = Qh[40];
        Qh[40] = 77;
        A[Qh[40]] = Qh[41];
        Qh[41] = 78;
        A[Qh[41]] = Qh[42];
        Qh[42] = 79;
        Qh[44] = function(...)
            while r42.AutoFarmEnabled do
                if not r34.Character then
                    task.wait(1);
                end;
                if A[Qh[39]]() >= r42.AutoFarmCoinLimit then
                    if r42.AutoRespawn then
                        r38("\xd0\x90\xd0\xb2\xd1\x82\xd0\xbe \xd1\x84\xd0\xb0\xd1\x80\xd0\xbc", "\xd0\xa0\xd0\xb5\xd1\x81\xd0\xbf\xd0\xb0\xd0\xb2\xd0\xbd... (" .. A[Qh[39]]() .. " \xd0\xbc\xd0\xbe\xd0\xbd\xd0\xb5\xd1\x82)", 2);
                        e = r34.Character;
                        if e then
                            Q = e.FindFirstChildOfClass(e, "Humanoid");
                            if Q then
                                Q.Health = 0;
                            end;
                        end;
                        task.wait(5);
                    else
                        r42.AutoFarmEnabled = false;
                        r38("\xd0\x90\xd0\xb2\xd1\x82\xd0\xbe \xd1\x84\xd0\xb0\xd1\x80\xd0\xbc", "\xd0\xa1\xd1\x83\xd0\xbc\xd0\xba\xd0\xb0 \xd0\xbf\xd0\xbe\xd0\xbb\xd0\xbd\xd0\xb0 - \xd0\xbe\xd1\x81\xd1\x82\xd0\xb0\xd0\xbd\xd0\xbe\xd0\xb2\xd0\xbb\xd0\xb5\xd0\xbd\xd0\xbe", 3);
                    end;
                else
                    if #A[Qh[40]]() == 0 then
                        task.wait(2);
                    else
                        H = A[Qh[41]](A[Qh[40]]()[1].part);
                        if H then
                            v3 = r42.AutoFarmEnabled;
                        end;
                        if H then
                            A[Qh[42]](A[Qh[40]]()[1].part);
                            task.wait(r42.AutoFarmCoinDelay);
                        end;
                        task.wait(.1);
                    end;
                end; 
            end;
            r43.AutoFarmConn = nil;
            return; 
        end;
        A[Qh[42]] = Qh[43];
        Qh[70] = 3094790587809;
        Qh[43] = 80;
        A[Qh[43]] = Qh[44];
        Qh[45] = function(...)
            if r42.AutoFarmEnabled then
                if not r34.Character then
                    return;
                end;
                r43.AutoFarmConn = task.spawn(A[Qh[43]]);
                r38("\xd0\x90\xd0\xb2\xd1\x82\xd0\xbe \xd1\x84\xd0\xb0\xd1\x80\xd0\xbc", "\xd0\x97\xd0\xb0\xd0\xbf\xd1\x83\xd1\x89\xd0\xb5\xd0\xbd", 3);
            else
                v5 = r34.Character;
                if v5 then
                    v5 = r34.Character;
                    v1 = v5.FindFirstChildOfClass(v5, "Humanoid");
                    if v1 then
                        v1.Sit = false;
                    end;
                end;
                if r43.CurrentTween then
                    pcall(function(...)
                        v5 = r43.CurrentTween;
                        v5.Cancel(v5);
                        return; 
                    end);
                    r43.CurrentTween = nil;
                end;
                return;
            end; 
        end;
        Qh[44] = 81;
        A[Qh[44]] = Qh[45];
        Qh[45] = nil;
        A[Qh[46]] = Qh[45];
        Qh[45] = nil;
        A[Qh[47]] = Qh[45];
        Qh[45] = 82;
        Qh[49] = function(...)
            A[Qh[45]]();
            if not r42.AntiFlingEnabled then
                return;
            end;
            v5 = r25.Heartbeat;
            A[Qh[46]] = v5.Connect(v5, function(...)
                v2 = 29578693817805;
                if not r42[r15[r16("\x8d\x0bE\xec\xd8\xa4\xe6\x93\x82\x82BG\x1d\xaf\xdd\x90", v2)]] then
                    A[Qh[45]]();
                    return;
                end;
                H = r24;
                j = H[3];
                H = H[1];
                for j, Q in H, ipairs(H.GetPlayers(H)) do
                    v2 = Q ~= r34;
                    e = j;
                    if v2 then
                        v4 = Q.Character;
                    end;
                    if v2 then
                        y = Q.Character;
                        w = {
                            y.GetDescendants(y)
                        };
                        v4 = y[1];
                        v2 = y[2];
                        for v7, w in ipairs(C(w)) do
                            y = v7;
                            if w.IsA(w, "BasePart") and w.CanCollide then
                                w.CanCollide = false;
                            end; 
                        end;
                    end; 
                end;
                v1 = r34.Character;
                if not v1 then
                    return;
                end;
                j = v1.FindFirstChild(v1, "HumanoidRootPart");
                if not j then
                    return;
                end;
                if j.AssemblyLinearVelocity.Magnitude > 200 then
                    j.AssemblyLinearVelocity = Vector3.new(0, 0, 0);
                end;
                if j.AssemblyAngularVelocity.Magnitude > 20 then
                    j.AssemblyAngularVelocity = Vector3.new(0, 0, 0);
                end;
                return; 
            end);
            v5 = r24.PlayerAdded;
            A[Qh[47]] = v5.Connect(v5, function(arg1_64, ...)
                v5 = arg1_64.CharacterAdded;
                v5.Connect(v5, function(arg1_65, ...)
                    v1 = arg1_65;
                    task.wait(0.5);
                    if not r42.AntiFlingEnabled then
                        return;
                    end;
                    Q = v1.GetDescendants;
                    e = {
                        Q(v1)
                    };
                    H = Q[3];
                    j = Q[2];
                    for H, v4 in ipairs(C("ipairs")) do
                        Q = H;
                        if v4.IsA(v4, "BasePart") then
                            v4.CanCollide = false;
                        end; 
                    end;
                    return; 
                end);
                return; 
            end);
            return; 
        end;
        A[Qh[45]] = Qh[48];
        Qh[48] = 83;
        A[Qh[48]] = Qh[49];
        Qh[49] = nil;
        A[Qh[50]] = Qh[49];
        Qh[49] = 84;
        A[Qh[49]] = Qh[51];
        Qh[52] = function(arg1_66, ...)
            v1 = arg1_66;
            r42.ShootButtonEnabled = v1;
            if v1 then
                A[Qh[49]]();
            else
                if r43.ShootButton then
                    pcall(function(...)
                        v5 = r43.ShootButton;
                        v5.Destroy(v5);
                        return; 
                    end);
                    r43.ShootButton = nil;
                end;
                return;
            end; 
        end;
        Qh[51] = 85;
        A[Qh[51]] = Qh[52];
        Qh[52] = 86;
        A[Qh[52]] = Qh[53];
        Qh[54] = function(...)
            if r43.mainConn then
                r45(r43.mainConn);
                r43.mainConn = nil;
            end;
            v1 = r25.Heartbeat;
            r43.mainConn = v1.Connect(v1, function(...)
                if r42.MurderESP or (r42.SheriffESP or (r42.InnocentESP or (r42.ChamsEnabled or (r42.Trails or r42.TracersEnabled)))) then
                    A[Qh[52]]();
                end;
                if r42.TracersEnabled then
                    r133();
                end;
                if r42.JumpCircles then
                    A[Qh[32]]();
                end;
                return; 
            end);
            return; 
        end;
        Qh[53] = 87;
        A[Qh[53]] = Qh[54];
        Qh[55] = r37;
        Qh[59] = r15;
        Qh[60] = r16;
        Qh[54] = function(...)
            H = r24;
            v1 = H[2];
            H = H[1];
            for j, Q in ipairs(H.GetPlayers(H)) do
                e = j;
                r166 = Q;
                v5 = r166 ~= r34;
                if v5 then
                    v5 = r166.CharacterRemoving;
                    v5.Connect(v5, function(...)
                        if r48(r166) then
                            r38("\xd0\xa8\xd0\xb5\xd1\x80\xd0\xb8\xd1\x84", r166.Name .. " \xd0\xbc\xd1\x91\xd1\x80\xd1\x82\xd0\xb2", 3);
                        end;
                        return; 
                    end);
                end; 
            end;
            v5 = r24.PlayerAdded;
            v5.Connect(v5, function(arg1_67, ...)
                r167 = arg1_67;
                v5 = r167.CharacterAdded;
                v5.Connect(v5, function(arg1_68, ...)
                    v1 = arg1_68;
                    v5 = v1.FindFirstChildOfClass(v1, "Humanoid");
                    if v5 then
                        v5 = v5.Died;
                        v5.Connect(v5, function(...)
                            if r48(r167) then
                                r38("\xd0\xa8\xd0\xb5\xd1\x80\xd0\xb8\xd1\x84", r167.Name .. " \xd0\xbc\xd1\x91\xd1\x80\xd1\x82\xd0\xb2", 3);
                            end;
                            return; 
                        end);
                    end;
                    return; 
                end);
                return; 
            end);
            return; 
        end;
        Qh[61] = Qh[60](Qh[62], Qh[63]);
        Qh[58] = Qh[59][Qh[61]];
        Qh[60] = r15;
        Qh[63] = "\xbd&\x95\xc4\xf2[\xc4\xc2h\x87j\x0e";
        Qh[56] = Qh[55][Qh[56]];
        Qh[61] = r16;
        Qh[62] = Qh[61](Qh[63], Qh[64]);
        Qh[59] = Qh[60][Qh[62]];
        Qh[61] = r15;
        Qh[64] = "\xb0\x02\xd0m";
        Qh[62] = r16;
        Qh[63] = Qh[62](Qh[64], Qh[65]);
        Qh[68] = 2045530670008;
        Qh[65] = "\x95\xedf";
        Qh[60] = Qh[61][Qh[63]];
        Qh[62] = r15;
        Qh[63] = r16;
        Qh[64] = Qh[63](Qh[65], Qh[66]);
        Qh[61] = Qh[62][Qh[64]];
        Qh[64] = 21597167101768;
        Qh[63] = 13070284904390;
        Qh[62] = "Z\x87d\x1b\xf9";
        Qh[65] = 16680226201175;
        Qh[57] = {
            [Qh[58]] = Qh[59],
            [Qh[60]] = Qh[61]
        };
        Qh[56] = Qh[56](Qh[55], Qh[57]);
        Qh[59] = r15;
        Qh[60] = r16;
        Qh[61] = Qh[60](Qh[62], Qh[63]);
        Qh[63] = "\x8c\xf2\xad";
        Qh[58] = Qh[59][Qh[61]];
        Qh[60] = r15;
        Qh[61] = r16;
        Qh[62] = Qh[61](Qh[63], Qh[64]);
        Qh[59] = Qh[60][Qh[62]];
        Qh[64] = "\xc4\xe0\xc7\x9f";
        Qh[61] = r15;
        Qh[55] = "Section";
        Qh[62] = r16;
        Qh[66] = 15739249679521;
        Qh[63] = Qh[62](Qh[64], Qh[65]);
        Qh[60] = Qh[61][Qh[63]];
        Qh[62] = r15;
        Qh[63] = r16;
        Qh[65] = "\xbaVV\xcf";
        Qh[64] = Qh[63](Qh[65], Qh[66]);
        Qh[63] = "\x88`m\x885";
        Qh[61] = Qh[62][Qh[64]];
        Qh[57] = {
            [Qh[58]] = Qh[59],
            [Qh[60]] = Qh[61]
        };
        Qh[55] = Qh[56][Qh[55]];
        Qh[55] = Qh[55](Qh[56], Qh[57]);
        Qh[64] = 27355207791042;
        Qh[60] = r15;
        Qh[61] = r16;
        Qh[62] = Qh[61](Qh[63], Qh[64]);
        Qh[65] = 26223838326707;
        Qh[64] = "\xf5g\x9e\x98\x97\xef\x86\x89-\xa8\x02\x05\xaf\x84\x85\x89";
        Qh[59] = Qh[60][Qh[62]];
        Qh[61] = r15;
        Qh[62] = r16;
        Qh[63] = Qh[62](Qh[64], Qh[65]);
        Qh[65] = "O\x93[}\xdelg";
        Qh[66] = 4278971893704;
        Qh[60] = Qh[61][Qh[63]];
        Qh[57] = "Toggle";
        Qh[62] = r15;
        Qh[63] = r16;
        Qh[64] = Qh[63](Qh[65], Qh[66]);
        Qh[61] = Qh[62][Qh[64]];
        Qh[57] = Qh[55][Qh[57]];
        Qh[64] = r15;
        Qh[62] = false;
        Qh[65] = r16;
        Qh[66] = Qh[65](Qh[67], Qh[68]);
        Qh[67] = "Ma\x91\xdf\xf9Dq\xc6";
        Qh[63] = Qh[64][Qh[66]];
        Qh[64] = function(arg1_69, ...)
            r42.MurderESP = arg1_69;
            A[Qh[53]]();
            return; 
        end;
        Qh[68] = 21471140013838;
        Qh[58] = {
            [Qh[59]] = Qh[60],
            [Qh[61]] = Qh[62],
            [Qh[63]] = Qh[64]
        };
        Qh[57] = Qh[57](Qh[55], Qh[58]);
        Qh[60] = r15;
        Qh[64] = 15074658737003;
        Qh[61] = r16;
        Qh[63] = "\xa9\x05v\x91\xa1";
        Qh[62] = Qh[61](Qh[63], Qh[64]);
        Qh[65] = 7024774548679;
        Qh[59] = Qh[60][Qh[62]];
        Qh[61] = r15;
        Qh[64] = "4Z\xe2\xa1\xfb\xacN\xd6zA\xcc\xaf/\x9d";
        Qh[62] = r16;
        Qh[63] = Qh[62](Qh[64], Qh[65]);
        Qh[60] = Qh[61][Qh[63]];
        Qh[62] = r15;
        Qh[65] = "\x85\xd5g\xe3\xe4\xbc\x8c";
        Qh[63] = r16;
        Qh[66] = 29542373717436;
        Qh[57] = "Toggle";
        Qh[64] = Qh[63](Qh[65], Qh[66]);
        Qh[61] = Qh[62][Qh[64]];
        Qh[62] = false;
        Qh[64] = r15;
        Qh[65] = r16;
        Qh[66] = Qh[65](Qh[67], Qh[68]);
        Qh[57] = Qh[55][Qh[57]];
        Qh[63] = Qh[64][Qh[66]];
        Qh[64] = function(arg1_70, ...)
            r42.SheriffESP = arg1_70;
            A[Qh[53]]();
            return; 
        end;
        Qh[58] = {
            [Qh[59]] = Qh[60],
            [Qh[61]] = Qh[62],
            [Qh[63]] = Qh[64]
        };
        Qh[68] = 17175477657405;
        Qh[67] = "\x82\xf2\x96\xfc\x1cN\"\xc5";
        Qh[57] = Qh[57](Qh[55], Qh[58]);
        Qh[57] = "Toggle";
        Qh[60] = r15;
        Qh[63] = "#\xa0\x01\x89\xe6";
        Qh[61] = r16;
        Qh[64] = 31471990651199;
        Qh[57] = Qh[55][Qh[57]];
        Qh[62] = Qh[61](Qh[63], Qh[64]);
        Qh[59] = Qh[60][Qh[62]];
        Qh[65] = 31082162436233;
        Qh[61] = r15;
        Qh[64] = ">\xec\xd0\x100\x8e\xb7@\xc5O\xa4\x84`}\xaa\xbb\x1f\x9f\xe3+";
        Qh[62] = r16;
        Qh[63] = Qh[62](Qh[64], Qh[65]);
        Qh[60] = Qh[61][Qh[63]];
        Qh[66] = 18273833836861;
        Qh[62] = r15;
        Qh[65] = "r\x89\xee\x7f\xae\xce\xc7";
        Qh[63] = r16;
        Qh[64] = Qh[63](Qh[65], Qh[66]);
        Qh[61] = Qh[62][Qh[64]];
        Qh[64] = r15;
        Qh[62] = false;
        Qh[65] = r16;
        Qh[66] = Qh[65](Qh[67], Qh[68]);
        Qh[63] = Qh[64][Qh[66]];
        Qh[64] = function(arg1_71, ...)
            r42.InnocentESP = arg1_71;
            A[Qh[53]]();
            return; 
        end;
        Qh[58] = {
            [Qh[59]] = Qh[60],
            [Qh[61]] = Qh[62],
            [Qh[63]] = Qh[64]
        };
        Qh[57] = Qh[57](Qh[55], Qh[58]);
        Qh[60] = r15;
        Qh[61] = r16;
        Qh[67] = 23102489045509;
        Qh[64] = 15477726682151;
        Qh[63] = "\xa4N\xaa\xff\xa9";
        Qh[65] = 788718453103;
        Qh[66] = 12791912027972;
        Qh[62] = Qh[61](Qh[63], Qh[64]);
        Qh[59] = Qh[60][Qh[62]];
        Qh[57] = "Section";
        Qh[61] = r15;
        Qh[64] = "\x92I\x11\xdb\xb7";
        Qh[62] = r16;
        Qh[68] = "\x06[\xcf\xc9W\r\x19\x1d";
        Qh[63] = Qh[62](Qh[64], Qh[65]);
        Qh[60] = Qh[61][Qh[63]];
        Qh[65] = "\x9e\xd6?\xb1";
        Qh[62] = r15;
        Qh[63] = r16;
        Qh[64] = Qh[63](Qh[65], Qh[66]);
        Qh[66] = "\xd4\xfb-\xfa)";
        Qh[61] = Qh[62][Qh[64]];
        Qh[63] = r15;
        Qh[64] = r16;
        Qh[65] = Qh[64](Qh[66], Qh[67]);
        Qh[62] = Qh[63][Qh[65]];
        Qh[57] = Qh[56][Qh[57]];
        Qh[58] = {
            [Qh[59]] = Qh[60],
            [Qh[61]] = Qh[62]
        };
        Qh[65] = 28518187365343;
        Qh[64] = "\xe9\xc3\x01\xdb\xa8";
        Qh[57] = Qh[57](Qh[56], Qh[58]);
        Qh[61] = r15;
        Qh[66] = 33396854357183;
        Qh[62] = r16;
        Qh[63] = Qh[62](Qh[64], Qh[65]);
        Qh[65] = "\x92~\xc9\xb6\xcf\xc7\xf1dq\xb9\rR\xc5k\xbdGq(\x90\xa81e";
        Qh[60] = Qh[61][Qh[63]];
        Qh[67] = 14799868861163;
        Qh[62] = r15;
        Qh[63] = r16;
        Qh[64] = Qh[63](Qh[65], Qh[66]);
        Qh[61] = Qh[62][Qh[64]];
        Qh[63] = r15;
        Qh[66] = "\xb9\x86\xaf\x1d\xf9l\x92";
        Qh[64] = r16;
        Qh[65] = Qh[64](Qh[66], Qh[67]);
        Qh[62] = Qh[63][Qh[65]];
        Qh[65] = r15;
        Qh[58] = "Toggle";
        Qh[66] = r16;
        Qh[63] = false;
        Qh[67] = Qh[66](Qh[68], Qh[69]);
        Qh[64] = Qh[65][Qh[67]];
        Qh[65] = function(arg1_72, ...)
            r42.ChamsEnabled = arg1_72;
            r126();
            A[Qh[53]]();
            return; 
        end;
        Qh[59] = {
            [Qh[60]] = Qh[61],
            [Qh[62]] = Qh[63],
            [Qh[64]] = Qh[65]
        };
        Qh[58] = Qh[57][Qh[58]];
        Qh[64] = "\x95\xc7>\xe4\x14";
        Qh[67] = 21598936491849;
        Qh[69] = 30992240506975;
        Qh[58] = Qh[58](Qh[57], Qh[59]);
        Qh[65] = 34544860675798;
        Qh[61] = r15;
        Qh[62] = r16;
        Qh[63] = Qh[62](Qh[64], Qh[65]);
        Qh[65] = "\x0c\x0fG\xceG\x932\xa4\xd0\x84LVZ\x16";
        Qh[60] = Qh[61][Qh[63]];
        Qh[62] = r15;
        Qh[66] = 9395073405206;
        Qh[63] = r16;
        Qh[64] = Qh[63](Qh[65], Qh[66]);
        Qh[68] = 12430773491356;
        Qh[61] = Qh[62][Qh[64]];
        Qh[66] = "\xf9\xe9~G!\xeb\x19";
        Qh[63] = r15;
        Qh[64] = r16;
        Qh[65] = Qh[64](Qh[66], Qh[67]);
        Qh[67] = "A\x01|\x8d\xba#";
        Qh[62] = Qh[63][Qh[65]];
        Qh[64] = r15;
        Qh[65] = r16;
        Qh[66] = Qh[65](Qh[67], Qh[68]);
        Qh[63] = Qh[64][Qh[66]];
        Qh[65] = r15;
        Qh[66] = r16;
        Qh[58] = "Input";
        Qh[68] = "\x1c\x93~\xf3rr\xef!aM\xca";
        Qh[67] = Qh[66](Qh[68], Qh[69]);
        Qh[64] = Qh[65][Qh[67]];
        Qh[66] = r15;
        Qh[67] = r16;
        Qh[69] = "\x81\x0e\xb2\x1e\x9e\xb9\xe3pPv\xd6RI\x81H\xb3\xad+\xb4\xb7\xf7\x05\xad\xca";
        Qh[68] = Qh[67](Qh[69], Qh[70]);
        Qh[65] = Qh[66][Qh[68]];
        Qh[67] = r15;
        Qh[68] = r16;
        Qh[70] = "&\x17\x98\xaa\xac\xb7\xf5\x10";
        Qh[69] = Qh[68](Qh[70], Qh[71]);
        Qh[66] = Qh[67][Qh[69]];
        Qh[67] = function(arg1_73, ...)
            v1 = arg1_73;
            if v1 == "Purple" or (v1 == "Blue" or (v1 == "Red" or v1 == "Green")) then
                j = arg1_73;
                r42.ChamsColor = j;
                if r42.ChamsEnabled then
                    r126();
                end;
            else
                r38("Chams", "\xd0\x94\xd0\xbe\xd1\x81\xd1\x82\xd1\x83\xd0\xbf\xd0\xbd\xd1\x8b\xd0\xb5 \xd1\x86\xd0\xb2\xd0\xb5\xd1\x82\xd0\xb0: Purple, Blue, Red, Green", 3);
            end;
            return; 
        end;
        Qh[58] = Qh[57][Qh[58]];
        Qh[69] = 29708212057609;
        Qh[59] = {
            [Qh[60]] = Qh[61],
            [Qh[62]] = Qh[63],
            [Qh[64]] = Qh[65],
            [Qh[66]] = Qh[67]
        };
        Qh[58] = Qh[58](Qh[57], Qh[59]);
        Qh[61] = r15;
        Qh[65] = 33810421726592;
        Qh[64] = "\xdc\x02\xaf\xfb\x06";
        Qh[62] = r16;
        Qh[67] = 1346564014707;
        Qh[63] = Qh[62](Qh[64], Qh[65]);
        Qh[60] = Qh[61][Qh[63]];
        Qh[62] = r15;
        Qh[65] = "\x1e\xebi\xf4\xa4c\x82e*\xc2.j\xe7L\x1c\xcd6\xbd\x0cq\xe4\xc2#\xb0Xv\xa4\xad,\x16\t";
        Qh[63] = r16;
        Qh[66] = 25365899669027;
        Qh[64] = Qh[63](Qh[65], Qh[66]);
        Qh[66] = "#%\xc8\xaa\xce\xca\x8d";
        Qh[58] = "Toggle";
        Qh[61] = Qh[62][Qh[64]];
        Qh[63] = r15;
        Qh[64] = r16;
        Qh[65] = Qh[64](Qh[66], Qh[67]);
        Qh[68] = "<\x1f\xe3\xde\xe13s\xd0";
        Qh[62] = Qh[63][Qh[65]];
        Qh[65] = r15;
        Qh[66] = r16;
        Qh[58] = Qh[57][Qh[58]];
        Qh[67] = Qh[66](Qh[68], Qh[69]);
        Qh[64] = Qh[65][Qh[67]];
        Qh[65] = function(arg1_74, ...)
            r42.RGBHumanoid = arg1_74;
            A[Qh[29]]();
            return; 
        end;
        Qh[63] = false;
        Qh[59] = {
            [Qh[60]] = Qh[61],
            [Qh[62]] = Qh[63],
            [Qh[64]] = Qh[65]
        };
        Qh[69] = 19310760125216;
        Qh[58] = Qh[58](Qh[57], Qh[59]);
        Qh[61] = r15;
        Qh[66] = 17816253833320;
        Qh[58] = "Toggle";
        Qh[65] = 18522041672112;
        Qh[64] = "`tX\xcc\x83";
        Qh[71] = 22335941929120;
        Qh[62] = r16;
        Qh[67] = 23933088099208;
        Qh[63] = Qh[62](Qh[64], Qh[65]);
        Qh[65] = "Th\x1e\xaf\xb2\xa7\xd1\x90\xd1\x9a)\xa8\x95\xf0\x85\xc8";
        Qh[60] = Qh[61][Qh[63]];
        Qh[62] = r15;
        Qh[63] = r16;
        Qh[64] = Qh[63](Qh[65], Qh[66]);
        Qh[66] = "\x99\x8a2\xee\xcb\xe5a";
        Qh[68] = "\xe0d\x87\x01u\xc0\xe3\xf4";
        Qh[61] = Qh[62][Qh[64]];
        Qh[63] = r15;
        Qh[64] = r16;
        Qh[65] = Qh[64](Qh[66], Qh[67]);
        Qh[62] = Qh[63][Qh[65]];
        Qh[65] = r15;
        Qh[63] = false;
        Qh[66] = r16;
        Qh[67] = Qh[66](Qh[68], Qh[69]);
        Qh[64] = Qh[65][Qh[67]];
        Qh[65] = function(arg1_75, ...)
            v1 = arg1_75;
            r42.TracersEnabled = v1;
            if v1 then
                e = r24;
                j = e[2];
                e = e[1];
                for H, v4 in ipairs(e.GetPlayers(e)) do
                    Q = H;
                    if v4 ~= r34 then
                        r132(v4);
                    end; 
                end;
            else
                A[Qh[1]]();
            end;
            A[Qh[53]]();
            return; 
        end;
        Qh[58] = Qh[55][Qh[58]];
        Qh[70] = 16291753188770;
        Qh[59] = {
            [Qh[60]] = Qh[61],
            [Qh[62]] = Qh[63],
            [Qh[64]] = Qh[65]
        };
        Qh[58] = Qh[58](Qh[55], Qh[59]);
        Qh[61] = r15;
        Qh[65] = 11851205039502;
        Qh[62] = r16;
        Qh[64] = "\x8d{\xbc\x06O";
        Qh[63] = Qh[62](Qh[64], Qh[65]);
        Qh[60] = Qh[61][Qh[63]];
        Qh[62] = r15;
        Qh[65] = "\x8b[\x1f\x15\xdd";
        Qh[63] = r16;
        Qh[66] = 12644575401728;
        Qh[67] = 28820648113260;
        Qh[64] = Qh[63](Qh[65], Qh[66]);
        Qh[66] = "r\x13\x00\xd7";
        Qh[61] = Qh[62][Qh[64]];
        Qh[63] = r15;
        Qh[69] = "\x04\rgv\xd3$BQ";
        Qh[68] = 26651073900666;
        Qh[64] = r16;
        Qh[65] = Qh[64](Qh[66], Qh[67]);
        Qh[58] = "Section";
        Qh[58] = Qh[56][Qh[58]];
        Qh[62] = Qh[63][Qh[65]];
        Qh[64] = r15;
        Qh[67] = "\xfa\x8b\x91\xe2";
        Qh[65] = r16;
        Qh[66] = Qh[65](Qh[67], Qh[68]);
        Qh[63] = Qh[64][Qh[66]];
        Qh[68] = 26011562487632;
        Qh[59] = {
            [Qh[60]] = Qh[61],
            [Qh[62]] = Qh[63]
        };
        Qh[58] = Qh[58](Qh[56], Qh[59]);
        Qh[62] = r15;
        Qh[65] = "q\xd7\xc0\xe2?";
        Qh[63] = r16;
        Qh[67] = 12917632259967;
        Qh[66] = 6896679783563;
        Qh[64] = Qh[63](Qh[65], Qh[66]);
        Qh[66] = "\xf8\xee\xce\xf9Ku\x7f\xe4\x02\x86\xab\x91";
        Qh[61] = Qh[62][Qh[64]];
        Qh[63] = r15;
        Qh[64] = r16;
        Qh[65] = Qh[64](Qh[66], Qh[67]);
        Qh[62] = Qh[63][Qh[65]];
        Qh[64] = r15;
        Qh[67] = "\x85\xfe\x07\xecs\xa5\xa0";
        Qh[65] = r16;
        Qh[59] = "Toggle";
        Qh[66] = Qh[65](Qh[67], Qh[68]);
        Qh[63] = Qh[64][Qh[66]];
        Qh[66] = r15;
        Qh[59] = Qh[58][Qh[59]];
        Qh[64] = false;
        Qh[67] = r16;
        Qh[68] = Qh[67](Qh[69], Qh[70]);
        Qh[65] = Qh[66][Qh[68]];
        Qh[66] = function(arg1_76, ...)
            A[Qh[20]](arg1_76);
            return; 
        end;
        Qh[60] = {
            [Qh[61]] = Qh[62],
            [Qh[63]] = Qh[64],
            [Qh[65]] = Qh[66]
        };
        Qh[65] = "\x88\xe8\x15\x96\x9a";
        Qh[66] = 34516568751817;
        Qh[70] = 2426987234410;
        Qh[59] = Qh[59](Qh[58], Qh[60]);
        Qh[62] = r15;
        Qh[63] = r16;
        Qh[64] = Qh[63](Qh[65], Qh[66]);
        Qh[61] = Qh[62][Qh[64]];
        Qh[63] = r15;
        Qh[67] = 3257963873773;
        Qh[66] = "\xdb[\x1ah\xb6\xeeF\x06\xacT}%\xa2\xc4\x039[20\x1a\x96B\x9f";
        Qh[68] = 12099621606914;
        Qh[64] = r16;
        Qh[65] = Qh[64](Qh[66], Qh[67]);
        Qh[69] = "\xbao\xdd\x96\xd6\xee\x04\xb4";
        Qh[62] = Qh[63][Qh[65]];
        Qh[64] = r15;
        Qh[65] = r16;
        Qh[67] = "3\xd0CO\x8e\x99\x0b";
        Qh[66] = Qh[65](Qh[67], Qh[68]);
        Qh[63] = Qh[64][Qh[66]];
        Qh[64] = false;
        Qh[59] = "Toggle";
        Qh[66] = r15;
        Qh[67] = r16;
        Qh[68] = Qh[67](Qh[69], Qh[70]);
        Qh[65] = Qh[66][Qh[68]];
        Qh[70] = "\xdcP?\x17s\xfe\xf7\x94";
        Qh[66] = function(arg1_77, ...)
            r82(arg1_77);
            return; 
        end;
        Qh[59] = Qh[58][Qh[59]];
        Qh[60] = {
            [Qh[61]] = Qh[62],
            [Qh[63]] = Qh[64],
            [Qh[65]] = Qh[66]
        };
        Qh[66] = 31427987044650;
        Qh[59] = Qh[59](Qh[58], Qh[60]);
        Qh[65] = "\xa7|\xfe\xd4\xbc";
        Qh[62] = r15;
        Qh[63] = r16;
        Qh[67] = 78325710884;
        Qh[64] = Qh[63](Qh[65], Qh[66]);
        Qh[59] = "Section";
        Qh[69] = 28692610004017;
        Qh[66] = "\x06Jr\x93&\x80\xd68";
        Qh[61] = Qh[62][Qh[64]];
        Qh[63] = r15;
        Qh[59] = Qh[56][Qh[59]];
        Qh[64] = r16;
        Qh[65] = Qh[64](Qh[66], Qh[67]);
        Qh[68] = 31745616148926;
        Qh[62] = Qh[63][Qh[65]];
        Qh[64] = r15;
        Qh[67] = "\x04/x\xba";
        Qh[65] = r16;
        Qh[66] = Qh[65](Qh[67], Qh[68]);
        Qh[63] = Qh[64][Qh[66]];
        Qh[65] = r15;
        Qh[66] = r16;
        Qh[68] = "\xcdQ\x8b\xfe\x06";
        Qh[67] = Qh[66](Qh[68], Qh[69]);
        Qh[68] = 7262187900213;
        Qh[64] = Qh[65][Qh[67]];
        Qh[60] = {
            [Qh[61]] = Qh[62],
            [Qh[63]] = Qh[64]
        };
        Qh[59] = Qh[59](Qh[56], Qh[60]);
        Qh[67] = 25286932590079;
        Qh[63] = r15;
        Qh[64] = r16;
        Qh[66] = "\x8e\xb9\x89\x1e\xc2";
        Qh[65] = Qh[64](Qh[66], Qh[67]);
        Qh[62] = Qh[63][Qh[65]];
        Qh[64] = r15;
        Qh[65] = r16;
        Qh[67] = "O\xfc@'3\xd08\x1c\xf2\x03k\x86*\x89j\x96\x8aG\x13\xc7\xe9\xc6\xb0\x03\x87";
        Qh[66] = Qh[65](Qh[67], Qh[68]);
        Qh[63] = Qh[64][Qh[66]];
        Qh[69] = 5847519611554;
        Qh[68] = "\x0ef\xf3\x84\xe6 \xd0";
        Qh[60] = "Toggle";
        Qh[65] = r15;
        Qh[66] = r16;
        Qh[67] = Qh[66](Qh[68], Qh[69]);
        Qh[64] = Qh[65][Qh[67]];
        Qh[67] = r15;
        Qh[65] = false;
        Qh[60] = Qh[59][Qh[60]];
        Qh[68] = r16;
        Qh[69] = Qh[68](Qh[70], Qh[71]);
        Qh[66] = Qh[67][Qh[69]];
        Qh[67] = function(arg1_78, ...)
            r67(arg1_78);
            return; 
        end;
        Qh[61] = {
            [Qh[62]] = Qh[63],
            [Qh[64]] = Qh[65],
            [Qh[66]] = Qh[67]
        };
        Qh[60] = Qh[60](Qh[59], Qh[61]);
        Qh[61] = "ipairs";
        Qh[60] = Env[Qh[61]];
        Qh[64] = r60;
        Qh[65] = {
            Qh[60](Qh[64])
        };
        Qh[63] = Qh[65][3];
        Qh[61] = Qh[65][1];
        Qh[62] = Qh[65][2];
        Qh[63], Qh[64] = Qh[61](Qh[62], Qh[63]);
        while Qh[63] do
            Qh[65] = 44;
            Qh[60] = Qh[63];
            Qh[71] = "\x96\x13\t\xd95";
            A[Qh[65]] = Qh[64];
            Qh[64] = Qh[65];
            Qh[60] = nil;
            Qh[65] = "Toggle";
            Qh[76] = 12517469509316;
            Qh[68] = r15;
            Qh[72] = 12321133368937;
            Qh[69] = r16;
            Qh[73] = "x+&\xfe\xcc\xcaD";
            Qh[70] = Qh[69](Qh[71], Qh[72]);
            Qh[67] = Qh[68][Qh[70]];
            Qh[68] = A[Qh[64]];
            Qh[65] = Qh[59][Qh[65]];
            Qh[74] = 4473569232931;
            Qh[69] = "upper";
            Qh[69] = Qh[68][Qh[69]];
            Qh[75] = "n@\xcb\x90\xce\xcf\xab\xf4";
            Qh[69] = Qh[69](Qh[68]);
            Qh[70] = r15;
            Qh[71] = r16;
            Qh[72] = Qh[71](Qh[73], Qh[74]);
            Qh[68] = Qh[70][Qh[72]];
            Qh[70] = false;
            Qh[72] = r15;
            Qh[73] = r16;
            Qh[74] = Qh[73](Qh[75], Qh[76]);
            Qh[71] = Qh[72][Qh[74]];
            Qh[72] = function(arg1_79, ...)
                j = arg1_79;
                r61[A[Qh[64]]] = j;
                if r42.AuraEnabled then
                    r66();
                end;
                return; 
            end;
            Qh[64] = nil;
            Qh[66] = {
                [Qh[67]] = Qh[69],
                [Qh[68]] = Qh[70],
                [Qh[71]] = Qh[72]
            };
            Qh[65] = Qh[65](Qh[59], Qh[66]); 
        end;
        Qh[67] = 34181781290541;
        Qh[66] = "\xe5_`\x0e\\";
        Qh[63] = r15;
        Qh[72] = 16316127108525;
        Qh[64] = r16;
        Qh[65] = Qh[64](Qh[66], Qh[67]);
        Qh[62] = Qh[63][Qh[65]];
        Qh[71] = 9721546920366;
        Qh[68] = 20972830926374;
        Qh[69] = 32189739072141;
        Qh[64] = r15;
        Qh[65] = r16;
        Qh[67] = "f\xe2\x00\xf3\xbe\xf5\xdbG\xa48\xfaG\x8c\xf4\xa6k";
        Qh[66] = Qh[65](Qh[67], Qh[68]);
        Qh[63] = Qh[64][Qh[66]];
        Qh[78] = 7190474132756;
        Qh[73] = 12237456774722;
        Qh[70] = 16813663018645;
        Qh[65] = r15;
        Qh[68] = "\xff`\x03:W\xc9=";
        Qh[66] = r16;
        Qh[67] = Qh[66](Qh[68], Qh[69]);
        Qh[69] = "\xd0\xcd\x1b\xa0\xdeP\xb6\xd5\xef\xb64";
        Qh[64] = Qh[65][Qh[67]];
        Qh[66] = r15;
        Qh[67] = r16;
        Qh[68] = Qh[67](Qh[69], Qh[70]);
        Qh[65] = Qh[66][Qh[68]];
        Qh[60] = "Input";
        Qh[67] = r15;
        Qh[68] = r16;
        Qh[60] = Qh[59][Qh[60]];
        Qh[70] = "\x0b\xdc\xd8\xaeA\xe6\x91$\x19\x1d*";
        Qh[69] = Qh[68](Qh[70], Qh[71]);
        Qh[74] = 1510742196927;
        Qh[71] = "\xdd\xce\x10\x92\xc7O\x82\xd3\x96\xee=";
        Qh[66] = Qh[67][Qh[69]];
        Qh[68] = r15;
        Qh[69] = r16;
        Qh[70] = Qh[69](Qh[71], Qh[72]);
        Qh[72] = "\xcd\xbd\x9e\x8b\xa2\xc7\xed\x10";
        Qh[67] = Qh[68][Qh[70]];
        Qh[69] = r15;
        Qh[70] = r16;
        Qh[71] = Qh[70](Qh[72], Qh[73]);
        Qh[68] = Qh[69][Qh[71]];
        Qh[69] = function(arg1_80, ...)
            v1 = arg1_80;
            j = {};
            Q = {
                v1.gmatch(v1, "[^,]+")
            };
            e = v1.gmatch(v1, "[^,]+");
            Q = Q[2];
            H = e(Q, Q[3]);
            while H do
                v4 = e(Q, Q[3]);
                table.insert(j, tonumber(v4)); 
            end;
            if #j == 3 then
                r42.AuraColor = Color3.fromRGB(j[1], j[2], j[3]);
                if r42.AuraEnabled then
                    r66();
                end;
            end;
            return; 
        end;
        Qh[61] = {
            [Qh[62]] = Qh[63],
            [Qh[64]] = Qh[65],
            [Qh[66]] = Qh[67],
            [Qh[68]] = Qh[69]
        };
        Qh[68] = 18791365059118;
        Qh[60] = Qh[60](Qh[59], Qh[61]);
        Qh[60] = r37;
        Qh[64] = r15;
        Qh[65] = r16;
        Qh[67] = "-\xd1\xe5~\x9f";
        Qh[70] = 16964763377371;
        Qh[66] = Qh[65](Qh[67], Qh[68]);
        Qh[73] = "&\xc6\xe8\xc0%\x16u\xd6";
        Qh[68] = "\xccL\xbc\x98v\x8e\x8a@\x84EN\x93\xf9\xe8";
        Qh[63] = Qh[64][Qh[66]];
        Qh[72] = 19245271196417;
        Qh[65] = r15;
        Qh[66] = r16;
        Qh[69] = 3866644137736;
        Qh[67] = Qh[66](Qh[68], Qh[69]);
        Qh[64] = Qh[65][Qh[67]];
        Qh[69] = "\x11k\xdal";
        Qh[66] = r15;
        Qh[67] = r16;
        Qh[71] = 18123561722103;
        Qh[68] = Qh[67](Qh[69], Qh[70]);
        Qh[65] = Qh[66][Qh[68]];
        Qh[61] = "Tab";
        Qh[70] = "\xc7\xc2\x8a\xab\x16\xaeu\x95";
        Qh[67] = r15;
        Qh[68] = r16;
        Qh[69] = Qh[68](Qh[70], Qh[71]);
        Qh[66] = Qh[67][Qh[69]];
        Qh[70] = 20550548956513;
        Qh[61] = Qh[60][Qh[61]];
        Qh[62] = {
            [Qh[63]] = Qh[64],
            [Qh[65]] = Qh[66]
        };
        Qh[61] = Qh[61](Qh[60], Qh[62]);
        Qh[64] = r15;
        Qh[65] = r16;
        Qh[67] = "\xcbq\x97\xae\x9f";
        Qh[68] = 7124608011509;
        Qh[69] = 29064384984286;
        Qh[60] = "Section";
        Qh[60] = Qh[61][Qh[60]];
        Qh[71] = 3368222950944;
        Qh[66] = Qh[65](Qh[67], Qh[68]);
        Qh[68] = "\xcbd:\x07\xf6\xc0\x04\xd0\xa3S\xc8>8X";
        Qh[63] = Qh[64][Qh[66]];
        Qh[65] = r15;
        Qh[66] = r16;
        Qh[67] = Qh[66](Qh[68], Qh[69]);
        Qh[64] = Qh[65][Qh[67]];
        Qh[69] = "\x01\xe2\xb1\xb3";
        Qh[66] = r15;
        Qh[67] = r16;
        Qh[68] = Qh[67](Qh[69], Qh[70]);
        Qh[65] = Qh[66][Qh[68]];
        Qh[70] = "\xca\x08Qk";
        Qh[67] = r15;
        Qh[68] = r16;
        Qh[69] = Qh[68](Qh[70], Qh[71]);
        Qh[86] = 34334388616820;
        Qh[66] = Qh[67][Qh[69]];
        Qh[62] = {
            [Qh[63]] = Qh[64],
            [Qh[65]] = Qh[66]
        };
        Qh[80] = 16740674756211;
        Qh[60] = Qh[60](Qh[61], Qh[62]);
        Qh[65] = r15;
        Qh[66] = r16;
        Qh[70] = 17111793016608;
        Qh[62] = "Section";
        Qh[68] = "Ue\x96\xe6\x12";
        Qh[69] = 29142710695170;
        Qh[67] = Qh[66](Qh[68], Qh[69]);
        Qh[64] = Qh[65][Qh[67]];
        Qh[69] = "\xff(\xe7\xa1\xecy";
        Qh[66] = r15;
        Qh[67] = r16;
        Qh[68] = Qh[67](Qh[69], Qh[70]);
        Qh[65] = Qh[66][Qh[68]];
        Qh[71] = 32060832971345;
        Qh[67] = r15;
        Qh[68] = r16;
        Qh[70] = "f\x82\xb6\xfd";
        Qh[69] = Qh[68](Qh[70], Qh[71]);
        Qh[62] = Qh[61][Qh[62]];
        Qh[66] = Qh[67][Qh[69]];
        Qh[75] = 16022754598181;
        Qh[71] = "Od\xb4Y`";
        Qh[68] = r15;
        Qh[69] = r16;
        Qh[70] = Qh[69](Qh[71], Qh[72]);
        Qh[67] = Qh[68][Qh[70]];
        Qh[63] = {
            [Qh[64]] = Qh[65],
            [Qh[66]] = Qh[67]
        };
        Qh[62] = Qh[62](Qh[61], Qh[63]);
        Qh[66] = r15;
        Qh[69] = "p\xa68\x1d\xb1";
        Qh[63] = "Toggle";
        Qh[70] = 24373980916822;
        Qh[72] = 6396841020322;
        Qh[67] = r16;
        Qh[71] = 2723980477684;
        Qh[68] = Qh[67](Qh[69], Qh[70]);
        Qh[65] = Qh[66][Qh[68]];
        Qh[67] = r15;
        Qh[70] = "\xf2\xe5\x06\xa7\xf8\xc2\xa8.g\xbeN\x1e\n\xbdA4\xec\xff\xe9\xb7\x8d\xb4\x97";
        Qh[68] = r16;
        Qh[69] = Qh[68](Qh[70], Qh[71]);
        Qh[66] = Qh[67][Qh[69]];
        Qh[68] = r15;
        Qh[71] = "B\xee@$\xb9,\xb3";
        Qh[69] = r16;
        Qh[70] = Qh[69](Qh[71], Qh[72]);
        Qh[67] = Qh[68][Qh[70]];
        Qh[68] = false;
        Qh[70] = r15;
        Qh[63] = Qh[60][Qh[63]];
        Qh[71] = r16;
        Qh[72] = Qh[71](Qh[73], Qh[74]);
        Qh[69] = Qh[70][Qh[72]];
        Qh[70] = function(arg1_81, ...)
            r42.JumpCircles = arg1_81;
            A[Qh[53]]();
            return; 
        end;
        Qh[72] = 6194958912324;
        Qh[71] = 15178439596956;
        Qh[64] = {
            [Qh[65]] = Qh[66],
            [Qh[67]] = Qh[68],
            [Qh[69]] = Qh[70]
        };
        Qh[69] = "\xae\x92\x84\xa1\x08";
        Qh[63] = Qh[63](Qh[60], Qh[64]);
        Qh[66] = r15;
        Qh[67] = r16;
        Qh[70] = 18914310529639;
        Qh[63] = "Toggle";
        Qh[68] = Qh[67](Qh[69], Qh[70]);
        Qh[65] = Qh[66][Qh[68]];
        Qh[67] = r15;
        Qh[68] = r16;
        Qh[70] = "n:\xf9GQ0\xfd\xcd#,J-\t/\x1b\xc0,e\xbe\x99\x98\xaat\x95\xce\xcb\x1b-\xcf";
        Qh[69] = Qh[68](Qh[70], Qh[71]);
        Qh[73] = "\xe0t\x0e\x99\xc0\x17\xc6\xb8";
        Qh[66] = Qh[67][Qh[69]];
        Qh[74] = 4702769350797;
        Qh[68] = r15;
        Qh[71] = "\xf5\xc5n\x88\xb9\xdd'";
        Qh[69] = r16;
        Qh[70] = Qh[69](Qh[71], Qh[72]);
        Qh[67] = Qh[68][Qh[70]];
        Qh[68] = false;
        Qh[63] = Qh[60][Qh[63]];
        Qh[70] = r15;
        Qh[71] = r16;
        Qh[72] = Qh[71](Qh[73], Qh[74]);
        Qh[69] = Qh[70][Qh[72]];
        Qh[70] = function(arg1_82, ...)
            v1 = arg1_82;
            r42.Trails = v1;
            if v1 then
                A[Qh[2]]();
            else
                A[Qh[3]]();
            end;
            A[Qh[53]]();
            return; 
        end;
        Qh[64] = {
            [Qh[65]] = Qh[66],
            [Qh[67]] = Qh[68],
            [Qh[69]] = Qh[70]
        };
        Qh[70] = 23008621947354;
        Qh[69] = "\x8d\xb1 _b";
        Qh[63] = Qh[63](Qh[60], Qh[64]);
        Qh[66] = r15;
        Qh[67] = r16;
        Qh[71] = 14424316271164;
        Qh[68] = Qh[67](Qh[69], Qh[70]);
        Qh[65] = Qh[66][Qh[68]];
        Qh[70] = "83{z";
        Qh[67] = r15;
        Qh[63] = "Toggle";
        Qh[73] = "\x85\x12\xb2\xe5[\x80\xb6e";
        Qh[68] = r16;
        Qh[69] = Qh[68](Qh[70], Qh[71]);
        Qh[71] = "\xa1\xd8N\xf1\xb2\xdb1";
        Qh[66] = Qh[67][Qh[69]];
        Qh[68] = r15;
        Qh[69] = r16;
        Qh[72] = 28499933672407;
        Qh[70] = Qh[69](Qh[71], Qh[72]);
        Qh[67] = Qh[68][Qh[70]];
        Qh[70] = r15;
        Qh[68] = false;
        Qh[71] = r16;
        Qh[74] = 61706616860;
        Qh[72] = Qh[71](Qh[73], Qh[74]);
        Qh[69] = Qh[70][Qh[72]];
        Qh[70] = function(arg1_83, ...)
            r42.XRayEnabled = arg1_83;
            A[Qh[30]]();
            return; 
        end;
        Qh[64] = {
            [Qh[65]] = Qh[66],
            [Qh[67]] = Qh[68],
            [Qh[69]] = Qh[70]
        };
        Qh[63] = Qh[60][Qh[63]];
        Qh[63] = Qh[63](Qh[60], Qh[64]);
        Qh[66] = r15;
        Qh[69] = "PZ\xa7\xd9\n";
        Qh[70] = 22276264077445;
        Qh[67] = r16;
        Qh[68] = Qh[67](Qh[69], Qh[70]);
        Qh[65] = Qh[66][Qh[68]];
        Qh[67] = r15;
        Qh[70] = "LI\xec\x98@";
        Qh[74] = 22949274266046;
        Qh[68] = r16;
        Qh[73] = "\x0bjc\x98EJa\xfb";
        Qh[71] = 5935439416011;
        Qh[69] = Qh[68](Qh[70], Qh[71]);
        Qh[66] = Qh[67][Qh[69]];
        Qh[72] = 13852149897522;
        Qh[68] = r15;
        Qh[69] = r16;
        Qh[71] = "\x01\x10\xcf\xcc>\xd2\xc2";
        Qh[70] = Qh[69](Qh[71], Qh[72]);
        Qh[67] = Qh[68][Qh[70]];
        Qh[68] = false;
        Qh[70] = r15;
        Qh[71] = r16;
        Qh[77] = 29090531489002;
        Qh[63] = "Toggle";
        Qh[72] = Qh[71](Qh[73], Qh[74]);
        Qh[69] = Qh[70][Qh[72]];
        Qh[70] = function(arg1_84, ...)
            v1 = arg1_84;
            r42.BloomEnabled = v1;
            A[Qh[4]](v1);
            return; 
        end;
        Qh[63] = Qh[60][Qh[63]];
        Qh[64] = {
            [Qh[65]] = Qh[66],
            [Qh[67]] = Qh[68],
            [Qh[69]] = Qh[70]
        };
        Qh[63] = Qh[63](Qh[60], Qh[64]);
        Qh[70] = 17718794035258;
        Qh[66] = r15;
        Qh[69] = "Wq\xffb\xa2";
        Qh[74] = 24843402063152;
        Qh[71] = 4729665554586;
        Qh[67] = r16;
        Qh[72] = 7665994108401;
        Qh[68] = Qh[67](Qh[69], Qh[70]);
        Qh[70] = "!\xd6Z\n\x7f\x08\xc6\xee\xb8\xab\x07]\x89\x9a\xe8,\xb438\x00\xd8i=\xeeb8\x9d\x94";
        Qh[65] = Qh[66][Qh[68]];
        Qh[67] = r15;
        Qh[63] = "Toggle";
        Qh[63] = Qh[60][Qh[63]];
        Qh[68] = r16;
        Qh[69] = Qh[68](Qh[70], Qh[71]);
        Qh[66] = Qh[67][Qh[69]];
        Qh[68] = r15;
        Qh[69] = r16;
        Qh[71] = "\xeb0\x18\xfe\xa2\xe7A";
        Qh[70] = Qh[69](Qh[71], Qh[72]);
        Qh[73] = "m\xf8R_i\xb1fl";
        Qh[67] = Qh[68][Qh[70]];
        Qh[68] = false;
        Qh[70] = r15;
        Qh[71] = r16;
        Qh[72] = Qh[71](Qh[73], Qh[74]);
        Qh[69] = Qh[70][Qh[72]];
        Qh[71] = 28211625014097;
        Qh[70] = function(arg1_85, ...)
            v1 = arg1_85;
            r42.ColorCorrectionEnabled = v1;
            A[Qh[5]](v1);
            return; 
        end;
        Qh[64] = {
            [Qh[65]] = Qh[66],
            [Qh[67]] = Qh[68],
            [Qh[69]] = Qh[70]
        };
        Qh[63] = Qh[63](Qh[60], Qh[64]);
        Qh[69] = "\xcf\xe9\x972:";
        Qh[74] = 10143963976307;
        Qh[70] = 28216543064915;
        Qh[66] = r15;
        Qh[67] = r16;
        Qh[63] = "Toggle";
        Qh[68] = Qh[67](Qh[69], Qh[70]);
        Qh[72] = 27752389145211;
        Qh[65] = Qh[66][Qh[68]];
        Qh[67] = r15;
        Qh[70] = "\xb5\xccCS \xd6`\n\xb9\x86\x08K\xadc\xb30";
        Qh[68] = r16;
        Qh[69] = Qh[68](Qh[70], Qh[71]);
        Qh[63] = Qh[60][Qh[63]];
        Qh[71] = "$\xd7$\x7fz\xa0\xcd";
        Qh[73] = "\xd5\xc4\xab\xbeZ\xdf\xf9\x84";
        Qh[66] = Qh[67][Qh[69]];
        Qh[68] = r15;
        Qh[69] = r16;
        Qh[70] = Qh[69](Qh[71], Qh[72]);
        Qh[67] = Qh[68][Qh[70]];
        Qh[70] = r15;
        Qh[68] = false;
        Qh[71] = r16;
        Qh[72] = Qh[71](Qh[73], Qh[74]);
        Qh[69] = Qh[70][Qh[72]];
        Qh[70] = function(arg1_86, ...)
            v1 = arg1_86;
            r42.VignetteEnabled = v1;
            A[Qh[6]](v1);
            return; 
        end;
        Qh[64] = {
            [Qh[65]] = Qh[66],
            [Qh[67]] = Qh[68],
            [Qh[69]] = Qh[70]
        };
        Qh[69] = "\x8fZ\x0f\x01\x7f";
        Qh[71] = 34517944909513;
        Qh[63] = Qh[63](Qh[60], Qh[64]);
        Qh[76] = 21522122745638;
        Qh[70] = 11813288236412;
        Qh[66] = r15;
        Qh[67] = r16;
        Qh[68] = Qh[67](Qh[69], Qh[70]);
        Qh[65] = Qh[66][Qh[68]];
        Qh[67] = r15;
        Qh[72] = 27812066374295;
        Qh[70] = "O\xe3\xa2\x84qV7\xed\xa3";
        Qh[68] = r16;
        Qh[73] = 18210129256735;
        Qh[69] = Qh[68](Qh[70], Qh[71]);
        Qh[66] = Qh[67][Qh[69]];
        Qh[68] = r15;
        Qh[69] = r16;
        Qh[71] = "+\x95\\\xab";
        Qh[70] = Qh[69](Qh[71], Qh[72]);
        Qh[63] = "Section";
        Qh[67] = Qh[68][Qh[70]];
        Qh[69] = r15;
        Qh[72] = ">/\xcb\xf6";
        Qh[70] = r16;
        Qh[71] = Qh[70](Qh[72], Qh[73]);
        Qh[63] = Qh[61][Qh[63]];
        Qh[70] = "p\xb4+\x15\x17";
        Qh[68] = Qh[69][Qh[71]];
        Qh[64] = {
            [Qh[65]] = Qh[66],
            [Qh[67]] = Qh[68]
        };
        Qh[63] = Qh[63](Qh[61], Qh[64]);
        Qh[71] = 844315001225;
        Qh[73] = 1940067697543;
        Qh[67] = r15;
        Qh[74] = "\x10\x9e\xfb\tn\xc1\xe6=";
        Qh[72] = 35009616101294;
        Qh[68] = r16;
        Qh[64] = "Toggle";
        Qh[69] = Qh[68](Qh[70], Qh[71]);
        Qh[66] = Qh[67][Qh[69]];
        Qh[71] = "\x93XX/)\xe1ez\xb0\xe1\x08o*\xb9\xce]";
        Qh[68] = r15;
        Qh[69] = r16;
        Qh[70] = Qh[69](Qh[71], Qh[72]);
        Qh[72] = "\xa0\x95\xbb\xf7\x12\xa3q";
        Qh[67] = Qh[68][Qh[70]];
        Qh[69] = r15;
        Qh[70] = r16;
        Qh[71] = Qh[70](Qh[72], Qh[73]);
        Qh[68] = Qh[69][Qh[71]];
        Qh[69] = false;
        Qh[71] = r15;
        Qh[72] = r16;
        Qh[73] = Qh[72](Qh[74], Qh[75]);
        Qh[70] = Qh[71][Qh[73]];
        Qh[64] = Qh[63][Qh[64]];
        Qh[75] = 21067153335890;
        Qh[71] = function(arg1_87, ...)
            A[Qh[27]](arg1_87);
            return; 
        end;
        Qh[65] = {
            [Qh[66]] = Qh[67],
            [Qh[68]] = Qh[69],
            [Qh[70]] = Qh[71]
        };
        Qh[64] = Qh[64](Qh[63], Qh[65]);
        Qh[71] = 6020202908403;
        Qh[67] = r15;
        Qh[64] = "Input";
        Qh[72] = 6642837048341;
        Qh[70] = "\xce\xb0<\xbb\x13";
        Qh[68] = r16;
        Qh[69] = Qh[68](Qh[70], Qh[71]);
        Qh[66] = Qh[67][Qh[69]];
        Qh[73] = 28206561162062;
        Qh[68] = r15;
        Qh[71] = "Zv(<\x18\x8d\xf7\x8b\xc9\xc5-\xf3\xf4A\x82\xa8\xf8Bk\xe1\xa9\xd6\xf0~\xdbt\xb5\xf2";
        Qh[69] = r16;
        Qh[70] = Qh[69](Qh[71], Qh[72]);
        Qh[67] = Qh[68][Qh[70]];
        Qh[72] = ":\xa5\x16\xaf\x1b;d";
        Qh[69] = r15;
        Qh[70] = r16;
        Qh[71] = Qh[70](Qh[72], Qh[73]);
        Qh[68] = Qh[69][Qh[71]];
        Qh[70] = r15;
        Qh[71] = r16;
        Qh[73] = "\x9b\xdb\xedo\xd5\x960";
        Qh[74] = 29028824855757;
        Qh[72] = Qh[71](Qh[73], Qh[74]);
        Qh[69] = Qh[70][Qh[72]];
        Qh[74] = "%LV(\x1f\x02\xe3]\xfen\xa9";
        Qh[71] = r15;
        Qh[72] = r16;
        Qh[73] = Qh[72](Qh[74], Qh[75]);
        Qh[75] = "\x02Etw\xfd|k\xde\xa8\x93A\r\xfd0}\x93)8\xb1a\xa3T";
        Qh[64] = Qh[63][Qh[64]];
        Qh[70] = Qh[71][Qh[73]];
        Qh[72] = r15;
        Qh[73] = r16;
        Qh[74] = Qh[73](Qh[75], Qh[76]);
        Qh[71] = Qh[72][Qh[74]];
        Qh[73] = r15;
        Qh[76] = "3a\xae=6\xa89K";
        Qh[74] = r16;
        Qh[75] = Qh[74](Qh[76], Qh[77]);
        Qh[72] = Qh[73][Qh[75]];
        Qh[74] = 1108582449668;
        Qh[73] = function(arg1_88, ...)
            v1 = arg1_88;
            if v1 == "Classic" or v1 == "Drawing" then
                A[Qh[28]](v1);
            else
                r38("China Hat", "\xd0\x94\xd0\xbe\xd1\x81\xd1\x82\xd1\x83\xd0\xbf\xd0\xbd\xd0\xbe: Classic, Drawing", 2);
            end;
            return; 
        end;
        Qh[75] = 32234397399714;
        Qh[65] = {
            [Qh[66]] = Qh[67],
            [Qh[68]] = Qh[69],
            [Qh[70]] = Qh[71],
            [Qh[72]] = Qh[73]
        };
        Qh[71] = 31563289000297;
        Qh[64] = Qh[64](Qh[63], Qh[65]);
        Qh[67] = r15;
        Qh[70] = "\xf3\xd3\xe9\xf2d";
        Qh[68] = r16;
        Qh[69] = Qh[68](Qh[70], Qh[71]);
        Qh[66] = Qh[67][Qh[69]];
        Qh[73] = 18266421305657;
        Qh[72] = 24568403291312;
        Qh[79] = "\xaa6\xb4}\x0c\x95a\xf4";
        Qh[68] = r15;
        Qh[64] = "Input";
        Qh[69] = r16;
        Qh[71] = "\xa1\x8cj\xeb\xca\t\xa3\x18\x00\xfc=\xab\x10\xecb\xe4\xd1\xaeP\x0f[0\x8a\x94LYyM!\xc0";
        Qh[77] = 34902632988540;
        Qh[70] = Qh[69](Qh[71], Qh[72]);
        Qh[67] = Qh[68][Qh[70]];
        Qh[69] = r15;
        Qh[70] = r16;
        Qh[64] = Qh[63][Qh[64]];
        Qh[72] = "\x97\xd4k\xf5f\xe3\xb7";
        Qh[71] = Qh[70](Qh[72], Qh[73]);
        Qh[68] = Qh[69][Qh[71]];
        Qh[70] = r15;
        Qh[73] = "\x94\xd7t";
        Qh[71] = r16;
        Qh[72] = Qh[71](Qh[73], Qh[74]);
        Qh[69] = Qh[70][Qh[72]];
        Qh[71] = r15;
        Qh[74] = "k\x96\x99h\x8e;W\x86f\xc5\xff";
        Qh[72] = r16;
        Qh[73] = Qh[72](Qh[74], Qh[75]);
        Qh[75] = "4D\"";
        Qh[70] = Qh[71][Qh[73]];
        Qh[72] = r15;
        Qh[76] = 7925451263594;
        Qh[73] = r16;
        Qh[74] = Qh[73](Qh[75], Qh[76]);
        Qh[71] = Qh[72][Qh[74]];
        Qh[73] = r15;
        Qh[76] = "\x94\xd9\x19\xf4\xbc^.i";
        Qh[74] = r16;
        Qh[75] = Qh[74](Qh[76], Qh[77]);
        Qh[72] = Qh[73][Qh[75]];
        Qh[73] = function(arg1_89, ...)
            j = tonumber(arg1_89);
            if j then
                r42.ChinaHatTransparency = math.clamp(j, 0, 1);
            end;
            return; 
        end;
        Qh[65] = {
            [Qh[66]] = Qh[67],
            [Qh[68]] = Qh[69],
            [Qh[70]] = Qh[71],
            [Qh[72]] = Qh[73]
        };
        Qh[64] = Qh[64](Qh[63], Qh[65]);
        Qh[71] = 27470650028536;
        Qh[67] = r15;
        Qh[64] = "Input";
        Qh[77] = 22309695432852;
        Qh[72] = 226160246889;
        Qh[70] = "]\x9d\xd1\xf5\x0c";
        Qh[68] = r16;
        Qh[69] = Qh[68](Qh[70], Qh[71]);
        Qh[66] = Qh[67][Qh[69]];
        Qh[68] = r15;
        Qh[69] = r16;
        Qh[71] = "G\xb9^$A\x08\x16\xca\x83\xeb\xff\n";
        Qh[70] = Qh[69](Qh[71], Qh[72]);
        Qh[67] = Qh[68][Qh[70]];
        Qh[72] = "JBL\xfb\xea\xf0\xf0";
        Qh[73] = 26040790069086;
        Qh[69] = r15;
        Qh[70] = r16;
        Qh[74] = 4099566159733;
        Qh[71] = Qh[70](Qh[72], Qh[73]);
        Qh[76] = 18668484338165;
        Qh[75] = 34744105156402;
        Qh[68] = Qh[69][Qh[71]];
        Qh[70] = r15;
        Qh[71] = r16;
        Qh[73] = "\xa0@k";
        Qh[64] = Qh[63][Qh[64]];
        Qh[72] = Qh[71](Qh[73], Qh[74]);
        Qh[69] = Qh[70][Qh[72]];
        Qh[71] = r15;
        Qh[74] = "\x0br\x8d\x91qkO\xcaM\x004";
        Qh[72] = r16;
        Qh[73] = Qh[72](Qh[74], Qh[75]);
        Qh[70] = Qh[71][Qh[73]];
        Qh[72] = r15;
        Qh[73] = r16;
        Qh[75] = "\xb7\xad:";
        Qh[74] = Qh[73](Qh[75], Qh[76]);
        Qh[71] = Qh[72][Qh[74]];
        Qh[73] = r15;
        Qh[76] = "\xa1\x12\xc6q\xa1b\xe3\x12";
        Qh[74] = r16;
        Qh[75] = Qh[74](Qh[76], Qh[77]);
        Qh[72] = Qh[73][Qh[75]];
        Qh[73] = function(arg1_90, ...)
            j = tonumber(arg1_90);
            if j then
                r42.ChinaHatRadius = math.max(j, 0.5);
            end;
            return; 
        end;
        Qh[65] = {
            [Qh[66]] = Qh[67],
            [Qh[68]] = Qh[69],
            [Qh[70]] = Qh[71],
            [Qh[72]] = Qh[73]
        };
        Qh[64] = Qh[64](Qh[63], Qh[65]);
        Qh[67] = r15;
        Qh[71] = 24249763130396;
        Qh[74] = 30892600178737;
        Qh[70] = "a\x9a\x9a\x00[";
        Qh[68] = r16;
        Qh[72] = 16426802650593;
        Qh[75] = 9448991723824;
        Qh[69] = Qh[68](Qh[70], Qh[71]);
        Qh[73] = 24513931242647;
        Qh[71] = "*\x039\xed$\xd4\xda\xf9\x03\xfchp";
        Qh[66] = Qh[67][Qh[69]];
        Qh[77] = 16775381409411;
        Qh[68] = r15;
        Qh[69] = r16;
        Qh[70] = Qh[69](Qh[71], Qh[72]);
        Qh[67] = Qh[68][Qh[70]];
        Qh[69] = r15;
        Qh[70] = r16;
        Qh[72] = "\xeel\x95[W\xbd\x1e";
        Qh[71] = Qh[70](Qh[72], Qh[73]);
        Qh[68] = Qh[69][Qh[71]];
        Qh[70] = r15;
        Qh[73] = "\x1d\x9d\x9e";
        Qh[71] = r16;
        Qh[72] = Qh[71](Qh[73], Qh[74]);
        Qh[69] = Qh[70][Qh[72]];
        Qh[71] = r15;
        Qh[64] = "Input";
        Qh[72] = r16;
        Qh[74] = "E\x08\xfa+\xfa\xf9\xd1Qg\xba\xe1";
        Qh[73] = Qh[72](Qh[74], Qh[75]);
        Qh[70] = Qh[71][Qh[73]];
        Qh[76] = 18358384009572;
        Qh[84] = 27753393500795;
        Qh[75] = "8\xd7\xfa";
        Qh[72] = r15;
        Qh[73] = r16;
        Qh[74] = Qh[73](Qh[75], Qh[76]);
        Qh[71] = Qh[72][Qh[74]];
        Qh[76] = "\x83\x02\x04\xf8\x89\xa8ME";
        Qh[73] = r15;
        Qh[74] = r16;
        Qh[75] = Qh[74](Qh[76], Qh[77]);
        Qh[72] = Qh[73][Qh[75]];
        Qh[75] = 4018486036303;
        Qh[73] = function(arg1_91, ...)
            j = tonumber(arg1_91);
            if j then
                r42.ChinaHatHeight = math.max(j, 0.5);
            end;
            return; 
        end;
        Qh[65] = {
            [Qh[66]] = Qh[67],
            [Qh[68]] = Qh[69],
            [Qh[70]] = Qh[71],
            [Qh[72]] = Qh[73]
        };
        Qh[64] = Qh[63][Qh[64]];
        Qh[64] = Qh[64](Qh[63], Qh[65]);
        Qh[76] = 1606517326572;
        Qh[67] = r15;
        Qh[68] = r16;
        Qh[71] = 3470858782288;
        Qh[72] = 4400757082113;
        Qh[70] = "\xf9\xccb\xa4M";
        Qh[69] = Qh[68](Qh[70], Qh[71]);
        Qh[74] = "lr/\xc4ZJ\xa0\xf4";
        Qh[66] = Qh[67][Qh[69]];
        Qh[71] = "\t\xba\x16\xf6*D\x87\x94x2\xb5h\xa5\x11+\x18\xb9\x0f3b\xb8S\x07\xfb9\xdc\x89";
        Qh[73] = 12106142193157;
        Qh[85] = 4213195392937;
        Qh[68] = r15;
        Qh[69] = r16;
        Qh[64] = "Toggle";
        Qh[70] = Qh[69](Qh[71], Qh[72]);
        Qh[67] = Qh[68][Qh[70]];
        Qh[69] = r15;
        Qh[70] = r16;
        Qh[72] = "\x17\xf6?\x17\x97<\xf1";
        Qh[71] = Qh[70](Qh[72], Qh[73]);
        Qh[68] = Qh[69][Qh[71]];
        Qh[69] = false;
        Qh[71] = r15;
        Qh[72] = r16;
        Qh[73] = Qh[72](Qh[74], Qh[75]);
        Qh[64] = Qh[63][Qh[64]];
        Qh[72] = 22284907341961;
        Qh[70] = Qh[71][Qh[73]];
        Qh[71] = function(arg1_92, ...)
            r42.ChinaHatRainbow = arg1_92;
            return; 
        end;
        Qh[65] = {
            [Qh[66]] = Qh[67],
            [Qh[68]] = Qh[69],
            [Qh[70]] = Qh[71]
        };
        Qh[64] = Qh[64](Qh[63], Qh[65]);
        Qh[67] = r15;
        Qh[68] = r16;
        Qh[71] = 1490173395637;
        Qh[70] = "c\x1d\xbf\x1f\xa0";
        Qh[69] = Qh[68](Qh[70], Qh[71]);
        Qh[66] = Qh[67][Qh[69]];
        Qh[68] = r15;
        Qh[71] = "\xd1\xc5\x80!x\xd5\xab\x1d\xa9\xb7\xc0p\xca\xff\xc3`";
        Qh[77] = 23806767065933;
        Qh[73] = 1888256426863;
        Qh[69] = r16;
        Qh[74] = 33724570795352;
        Qh[70] = Qh[69](Qh[71], Qh[72]);
        Qh[67] = Qh[68][Qh[70]];
        Qh[72] = "\xa7A\xac)\x90\xf3\xe8";
        Qh[75] = 30210358605555;
        Qh[69] = r15;
        Qh[70] = r16;
        Qh[71] = Qh[70](Qh[72], Qh[73]);
        Qh[64] = "Input";
        Qh[68] = Qh[69][Qh[71]];
        Qh[70] = r15;
        Qh[73] = "P'\xf7FW\xde\x16\xb4h";
        Qh[71] = r16;
        Qh[72] = Qh[71](Qh[73], Qh[74]);
        Qh[64] = Qh[63][Qh[64]];
        Qh[69] = Qh[70][Qh[72]];
        Qh[71] = r15;
        Qh[74] = "U\xe5\x9c\x1a\xf7\xca\x7f\xc8H\xa8\xd8";
        Qh[72] = r16;
        Qh[73] = Qh[72](Qh[74], Qh[75]);
        Qh[75] = "h\x98\xbc\\%7\xb2\x9d\xac";
        Qh[70] = Qh[71][Qh[73]];
        Qh[72] = r15;
        Qh[73] = r16;
        Qh[74] = Qh[73](Qh[75], Qh[76]);
        Qh[71] = Qh[72][Qh[74]];
        Qh[73] = r15;
        Qh[74] = r16;
        Qh[76] = "`i\x08\x18V\xfa+\xd3";
        Qh[75] = Qh[74](Qh[76], Qh[77]);
        Qh[72] = Qh[73][Qh[75]];
        Qh[73] = function(arg1_93, ...)
            v1 = arg1_93;
            j = {};
            Q = {
                v1.gmatch(v1, "[^,]+")
            };
            Q = Q[2];
            e = Q[1];
            H = e(Q, Q[3]);
            while H do
                v4 = e(Q, Q[3]);
                table.insert(j, tonumber(v4)); 
            end;
            if #j == 3 then
                r42.ChinaHatColor = Color3.fromRGB(j[1], j[2], j[3]);
            end;
            return; 
        end;
        Qh[65] = {
            [Qh[66]] = Qh[67],
            [Qh[68]] = Qh[69],
            [Qh[70]] = Qh[71],
            [Qh[72]] = Qh[73]
        };
        Qh[75] = 23996708449190;
        Qh[64] = Qh[64](Qh[63], Qh[65]);
        Qh[67] = r15;
        Qh[68] = r16;
        Qh[70] = "\x9f\xe2\x16\xee\xa9";
        Qh[71] = 33176733531225;
        Qh[69] = Qh[68](Qh[70], Qh[71]);
        Qh[72] = 23592660380394;
        Qh[76] = 23997321325478;
        Qh[74] = 20302056858861;
        Qh[77] = 9367447884042;
        Qh[66] = Qh[67][Qh[69]];
        Qh[68] = r15;
        Qh[73] = 5503592991234;
        Qh[71] = "\xf3\xda\x90J\x03L\xbeW\xbc\xf5\xa6j\xb8\xea\xf2+\xe7V\xf6";
        Qh[69] = r16;
        Qh[64] = "Input";
        Qh[70] = Qh[69](Qh[71], Qh[72]);
        Qh[67] = Qh[68][Qh[70]];
        Qh[72] = "FI\xa0\xfd\t\xc2K";
        Qh[69] = r15;
        Qh[70] = r16;
        Qh[71] = Qh[70](Qh[72], Qh[73]);
        Qh[68] = Qh[69][Qh[71]];
        Qh[73] = "\xd3\xa2";
        Qh[70] = r15;
        Qh[71] = r16;
        Qh[89] = 12565788202715;
        Qh[72] = Qh[71](Qh[73], Qh[74]);
        Qh[69] = Qh[70][Qh[72]];
        Qh[71] = r15;
        Qh[72] = r16;
        Qh[74] = "F\xb4l\x11\x0e \xc9\xff\x01\xcc\xb4";
        Qh[73] = Qh[72](Qh[74], Qh[75]);
        Qh[75] = "@0b\x9c\x14r\xb2\xc2\xa7\x8b\xba\xd1\rzr=\x04\xb5\xeb\xb0\xe7\t\x91";
        Qh[70] = Qh[71][Qh[73]];
        Qh[72] = r15;
        Qh[73] = r16;
        Qh[74] = Qh[73](Qh[75], Qh[76]);
        Qh[76] = "\x18\xbb\xbe\x0c\xdb`\x12:";
        Qh[82] = 2851496363311;
        Qh[71] = Qh[72][Qh[74]];
        Qh[73] = r15;
        Qh[74] = r16;
        Qh[64] = Qh[62][Qh[64]];
        Qh[75] = Qh[74](Qh[76], Qh[77]);
        Qh[72] = Qh[73][Qh[75]];
        Qh[73] = function(arg1_94, ...)
            r42.CustomSkyId = arg1_94;
            return; 
        end;
        Qh[65] = {
            [Qh[66]] = Qh[67],
            [Qh[68]] = Qh[69],
            [Qh[70]] = Qh[71],
            [Qh[72]] = Qh[73]
        };
        Qh[64] = Qh[64](Qh[62], Qh[65]);
        Qh[67] = r15;
        Qh[68] = r16;
        Qh[71] = 13326880462909;
        Qh[72] = 5075675957563;
        Qh[70] = "\x85\xdaM\xe0{";
        Qh[64] = "Button";
        Qh[69] = Qh[68](Qh[70], Qh[71]);
        Qh[66] = Qh[67][Qh[69]];
        Qh[68] = r15;
        Qh[73] = 14688130718391;
        Qh[71] = "\xceH/\x1bX\xe1\x07i|\xe5y\x89\xca)\n\x99.\xd6\xf8Q\xe6q>\xb0N\xb3a";
        Qh[69] = r16;
        Qh[70] = Qh[69](Qh[71], Qh[72]);
        Qh[72] = "\x05\xd6'\xc1\xfd\xc8\x8e\xf4";
        Qh[67] = Qh[68][Qh[70]];
        Qh[69] = r15;
        Qh[70] = r16;
        Qh[71] = Qh[70](Qh[72], Qh[73]);
        Qh[68] = Qh[69][Qh[71]];
        Qh[71] = 25321916165647;
        Qh[69] = function(...)
            if r42.CustomSkyId and r42.CustomSkyId ~= "" then
                A[Qh[10]](r42.CustomSkyId);
            end;
            return; 
        end;
        Qh[72] = 14875630181135;
        Qh[74] = 13042873178041;
        Qh[64] = Qh[62][Qh[64]];
        Qh[65] = {
            [Qh[66]] = Qh[67],
            [Qh[68]] = Qh[69]
        };
        Qh[64] = Qh[64](Qh[62], Qh[65]);
        Qh[67] = r15;
        Qh[68] = r16;
        Qh[70] = "n\xe7N\x0c'";
        Qh[69] = Qh[68](Qh[70], Qh[71]);
        Qh[71] = "5b\x94O\xaan\xc2\xa9\xfb_\xab\xeb\xb6\xaa\xfe\xa5\xa5\xb1\xb8\x81\xb9%\xae";
        Qh[77] = 30705166710746;
        Qh[66] = Qh[67][Qh[69]];
        Qh[64] = "Button";
        Qh[68] = r15;
        Qh[69] = r16;
        Qh[73] = 20871577970167;
        Qh[64] = Qh[62][Qh[64]];
        Qh[70] = Qh[69](Qh[71], Qh[72]);
        Qh[67] = Qh[68][Qh[70]];
        Qh[69] = r15;
        Qh[70] = r16;
        Qh[72] = "\xde\xfbr\xf5Q\xad{\xa0";
        Qh[71] = Qh[70](Qh[72], Qh[73]);
        Qh[68] = Qh[69][Qh[71]];
        Qh[69] = function(...)
            A[Qh[11]]();
            return; 
        end;
        Qh[72] = 15655304158330;
        Qh[65] = {
            [Qh[66]] = Qh[67],
            [Qh[68]] = Qh[69]
        };
        Qh[64] = Qh[64](Qh[62], Qh[65]);
        Qh[70] = "2pWP\xfe";
        Qh[67] = r15;
        Qh[68] = r16;
        Qh[71] = 29340402201950;
        Qh[69] = Qh[68](Qh[70], Qh[71]);
        Qh[66] = Qh[67][Qh[69]];
        Qh[68] = r15;
        Qh[73] = 22361751365805;
        Qh[71] = "\x95\x8b@^\x9dY<'%*\xe5j";
        Qh[69] = r16;
        Qh[70] = Qh[69](Qh[71], Qh[72]);
        Qh[67] = Qh[68][Qh[70]];
        Qh[69] = r15;
        Qh[72] = "b)\x01\x9dz\x10\xf4\x7f";
        Qh[64] = "Button";
        Qh[70] = r16;
        Qh[71] = Qh[70](Qh[72], Qh[73]);
        Qh[70] = "\xab\x07\x0cD\x8e";
        Qh[64] = Qh[62][Qh[64]];
        Qh[75] = 33557272362250;
        Qh[68] = Qh[69][Qh[71]];
        Qh[69] = function(...)
            A[Qh[10]]("Space");
            return; 
        end;
        Qh[65] = {
            [Qh[66]] = Qh[67],
            [Qh[68]] = Qh[69]
        };
        Qh[64] = Qh[64](Qh[62], Qh[65]);
        Qh[72] = 20901950055941;
        Qh[67] = r15;
        Qh[68] = r16;
        Qh[71] = 17543560601577;
        Qh[69] = Qh[68](Qh[70], Qh[71]);
        Qh[66] = Qh[67][Qh[69]];
        Qh[71] = "\x19\xe9\x1c89\xec.(B\x0b\xc7\xa9D=\xdd\x9f=\xbc";
        Qh[68] = r15;
        Qh[69] = r16;
        Qh[73] = 11466923955419;
        Qh[64] = "Button";
        Qh[70] = Qh[69](Qh[71], Qh[72]);
        Qh[64] = Qh[62][Qh[64]];
        Qh[72] = "\xcf\xd5\xdd\xb4Y\xd7\xc0\xef";
        Qh[67] = Qh[68][Qh[70]];
        Qh[69] = r15;
        Qh[70] = r16;
        Qh[71] = Qh[70](Qh[72], Qh[73]);
        Qh[68] = Qh[69][Qh[71]];
        Qh[71] = "$\xa3\xc4S,";
        Qh[69] = function(...)
            A[Qh[10]]("Galaxy");
            return; 
        end;
        Qh[65] = {
            [Qh[66]] = Qh[67],
            [Qh[68]] = Qh[69]
        };
        Qh[72] = 9524345033043;
        Qh[64] = Qh[64](Qh[62], Qh[65]);
        Qh[73] = 7445614644619;
        Qh[64] = r37;
        Qh[81] = 9464164077879;
        Qh[68] = r15;
        Qh[69] = r16;
        Qh[70] = Qh[69](Qh[71], Qh[72]);
        Qh[67] = Qh[68][Qh[70]];
        Qh[69] = r15;
        Qh[70] = r16;
        Qh[72] = "\x87\xaa\x10\n&\xb9\xb6\x8b\xbc\x0e";
        Qh[71] = Qh[70](Qh[72], Qh[73]);
        Qh[73] = "`f+1";
        Qh[76] = 5520367241738;
        Qh[68] = Qh[69][Qh[71]];
        Qh[65] = "Tab";
        Qh[65] = Qh[64][Qh[65]];
        Qh[70] = r15;
        Qh[71] = r16;
        Qh[72] = Qh[71](Qh[73], Qh[74]);
        Qh[69] = Qh[70][Qh[72]];
        Qh[71] = r15;
        Qh[72] = r16;
        Qh[74] = "\xb3\xdfu\xa8\x7f";
        Qh[73] = Qh[72](Qh[74], Qh[75]);
        Qh[70] = Qh[71][Qh[73]];
        Qh[71] = "qIk>{";
        Qh[66] = {
            [Qh[67]] = Qh[68],
            [Qh[69]] = Qh[70]
        };
        Qh[74] = 21965560637428;
        Qh[65] = Qh[65](Qh[64], Qh[66]);
        Qh[68] = r15;
        Qh[73] = 11035234604050;
        Qh[72] = 29465095402904;
        Qh[69] = r16;
        Qh[70] = Qh[69](Qh[71], Qh[72]);
        Qh[67] = Qh[68][Qh[70]];
        Qh[69] = r15;
        Qh[64] = "Section";
        Qh[70] = r16;
        Qh[72] = "<Q\xa5\xf7\xd7\xa9o\xdc\xf1\x08f\x90\xd8\x03!\xed";
        Qh[75] = 34968688394139;
        Qh[71] = Qh[70](Qh[72], Qh[73]);
        Qh[68] = Qh[69][Qh[71]];
        Qh[73] = "6\x9f\xb7\xe2";
        Qh[70] = r15;
        Qh[64] = Qh[65][Qh[64]];
        Qh[71] = r16;
        Qh[72] = Qh[71](Qh[73], Qh[74]);
        Qh[69] = Qh[70][Qh[72]];
        Qh[71] = r15;
        Qh[72] = r16;
        Qh[74] = "\xa0P\xdd\xc7";
        Qh[73] = Qh[72](Qh[74], Qh[75]);
        Qh[70] = Qh[71][Qh[73]];
        Qh[66] = {
            [Qh[67]] = Qh[68],
            [Qh[69]] = Qh[70]
        };
        Qh[64] = Qh[64](Qh[65], Qh[66]);
        Qh[75] = 23781637614402;
        Qh[73] = 31337291462912;
        Qh[72] = "\x102w(?";
        Qh[69] = r15;
        Qh[70] = r16;
        Qh[71] = Qh[70](Qh[72], Qh[73]);
        Qh[68] = Qh[69][Qh[71]];
        Qh[70] = r15;
        Qh[73] = "\xbbd\x95\x01\xc3c\x1eXq{";
        Qh[74] = 10777896981402;
        Qh[71] = r16;
        Qh[72] = Qh[71](Qh[73], Qh[74]);
        Qh[74] = "\xf5\n\x9c\x0e";
        Qh[69] = Qh[70][Qh[72]];
        Qh[71] = r15;
        Qh[72] = r16;
        Qh[73] = Qh[72](Qh[74], Qh[75]);
        Qh[70] = Qh[71][Qh[73]];
        Qh[72] = r15;
        Qh[73] = r16;
        Qh[75] = "?2\xa0\xad\xc8";
        Qh[74] = Qh[73](Qh[75], Qh[76]);
        Qh[71] = Qh[72][Qh[74]];
        Qh[66] = "Section";
        Qh[75] = 1924145988480;
        Qh[74] = 16017035992354;
        Qh[73] = "M\xcd\xa9\xe0\xe9";
        Qh[67] = {
            [Qh[68]] = Qh[69],
            [Qh[70]] = Qh[71]
        };
        Qh[66] = Qh[65][Qh[66]];
        Qh[66] = Qh[66](Qh[65], Qh[67]);
        Qh[70] = r15;
        Qh[71] = r16;
        Qh[72] = Qh[71](Qh[73], Qh[74]);
        Qh[69] = Qh[70][Qh[72]];
        Qh[71] = r15;
        Qh[74] = "x\xc0\xfe\x1e\xc1wB\xfc\x13}\xc7\x9aK\xc2\x056\xdf\xa2";
        Qh[72] = r16;
        Qh[73] = Qh[72](Qh[74], Qh[75]);
        Qh[70] = Qh[71][Qh[73]];
        Qh[75] = "\x86\x04\x07\x9d";
        Qh[67] = "Section";
        Qh[72] = r15;
        Qh[73] = r16;
        Qh[67] = Qh[65][Qh[67]];
        Qh[76] = 10596043215686;
        Qh[74] = Qh[73](Qh[75], Qh[76]);
        Qh[76] = "\xe1z\x18\x95";
        Qh[71] = Qh[72][Qh[74]];
        Qh[73] = r15;
        Qh[74] = r16;
        Qh[75] = Qh[74](Qh[76], Qh[77]);
        Qh[74] = "\xd7\"\x96\xe5o";
        Qh[72] = Qh[73][Qh[75]];
        Qh[75] = 33609410460962;
        Qh[68] = {
            [Qh[69]] = Qh[70],
            [Qh[71]] = Qh[72]
        };
        Qh[67] = Qh[67](Qh[65], Qh[68]);
        Qh[76] = 32447100599045;
        Qh[71] = r15;
        Qh[77] = 5995667704551;
        Qh[72] = r16;
        Qh[73] = Qh[72](Qh[74], Qh[75]);
        Qh[75] = "\x05\xbd\xd6\xa4O\x05\xb1w\xbe\r\x9f\x91,\xa5i\x96";
        Qh[70] = Qh[71][Qh[73]];
        Qh[72] = r15;
        Qh[73] = r16;
        Qh[74] = Qh[73](Qh[75], Qh[76]);
        Qh[71] = Qh[72][Qh[74]];
        Qh[73] = r15;
        Qh[76] = " \xa1Qn";
        Qh[74] = r16;
        Qh[75] = Qh[74](Qh[76], Qh[77]);
        Qh[72] = Qh[73][Qh[75]];
        Qh[68] = "Section";
        Qh[68] = Qh[65][Qh[68]];
        Qh[77] = "6\xb1\x9ar[";
        Qh[74] = r15;
        Qh[75] = r16;
        Qh[76] = Qh[75](Qh[77], Qh[78]);
        Qh[73] = Qh[74][Qh[76]];
        Qh[69] = {
            [Qh[70]] = Qh[71],
            [Qh[72]] = Qh[73]
        };
        Qh[77] = 20871297885686;
        Qh[68] = Qh[68](Qh[65], Qh[69]);
        Qh[76] = 22584644659476;
        Qh[72] = r15;
        Qh[69] = "Toggle";
        Qh[75] = " 8\x8e\xe7\x1b";
        Qh[78] = 28062052102923;
        Qh[73] = r16;
        Qh[74] = Qh[73](Qh[75], Qh[76]);
        Qh[71] = Qh[72][Qh[74]];
        Qh[76] = ":YvK\xeb\xfc\x93^\x96\x9c";
        Qh[73] = r15;
        Qh[74] = r16;
        Qh[75] = Qh[74](Qh[76], Qh[77]);
        Qh[72] = Qh[73][Qh[75]];
        Qh[74] = r15;
        Qh[75] = r16;
        Qh[77] = "\xf2+)L\xca-w";
        Qh[76] = Qh[75](Qh[77], Qh[78]);
        Qh[73] = Qh[74][Qh[76]];
        Qh[74] = false;
        Qh[76] = r15;
        Qh[77] = r16;
        Qh[78] = Qh[77](Qh[79], Qh[80]);
        Qh[69] = Qh[66][Qh[69]];
        Qh[75] = Qh[76][Qh[78]];
        Qh[76] = function(arg1_95, ...)
            r71(arg1_95);
            return; 
        end;
        Qh[78] = 33181612211291;
        Qh[77] = 15239431363512;
        Qh[70] = {
            [Qh[71]] = Qh[72],
            [Qh[73]] = Qh[74],
            [Qh[75]] = Qh[76]
        };
        Qh[69] = Qh[69](Qh[66], Qh[70]);
        Qh[72] = r15;
        Qh[75] = "<\xb2}\xf9@";
        Qh[73] = r16;
        Qh[76] = 1342229938801;
        Qh[74] = Qh[73](Qh[75], Qh[76]);
        Qh[71] = Qh[72][Qh[74]];
        Qh[76] = "F\xb8p\x99\xf9\xbd\xca\x13>%\x14q<\x91!\x95\xf1\x8b\xbd\x07\x9b\xac\x8d\xce\xfe\x1b3]'";
        Qh[69] = "Input";
        Qh[73] = r15;
        Qh[80] = 957009314237;
        Qh[74] = r16;
        Qh[75] = Qh[74](Qh[76], Qh[77]);
        Qh[77] = "~u\xb6\xb6T\x18\xe0";
        Qh[72] = Qh[73][Qh[75]];
        Qh[74] = r15;
        Qh[79] = 18885790540378;
        Qh[75] = r16;
        Qh[76] = Qh[75](Qh[77], Qh[78]);
        Qh[73] = Qh[74][Qh[76]];
        Qh[75] = r15;
        Qh[76] = r16;
        Qh[78] = "\xfc\xed";
        Qh[77] = Qh[76](Qh[78], Qh[79]);
        Qh[74] = Qh[75][Qh[77]];
        Qh[76] = r15;
        Qh[77] = r16;
        Qh[79] = "^\xcf\xae6\x00\xe6T\xc9Ne8";
        Qh[69] = Qh[66][Qh[69]];
        Qh[78] = Qh[77](Qh[79], Qh[80]);
        Qh[75] = Qh[76][Qh[78]];
        Qh[77] = r15;
        Qh[78] = r16;
        Qh[80] = "\xc9\x19";
        Qh[79] = Qh[78](Qh[80], Qh[81]);
        Qh[76] = Qh[77][Qh[79]];
        Qh[78] = r15;
        Qh[79] = r16;
        Qh[81] = "Y\xccyVr\x8a\xe8\x02";
        Qh[80] = Qh[79](Qh[81], Qh[82]);
        Qh[77] = Qh[78][Qh[80]];
        Qh[78] = function(arg1_96, ...)
            j = tonumber(arg1_96);
            if j then
                H = "FlySpeed";
                r42.FlySpeed = H;
            end;
            return; 
        end;
        Qh[70] = {
            [Qh[71]] = Qh[72],
            [Qh[73]] = Qh[74],
            [Qh[75]] = Qh[76],
            [Qh[77]] = Qh[78]
        };
        Qh[69] = Qh[69](Qh[66], Qh[70]);
        Qh[72] = r15;
        Qh[76] = 16909778722498;
        Qh[75] = "O\xedU\xf1\xef";
        Qh[73] = r16;
        Qh[74] = Qh[73](Qh[75], Qh[76]);
        Qh[71] = Qh[72][Qh[74]];
        Qh[73] = r15;
        Qh[76] = "P\x07\xa2\x82\x88\x11\xb9\x9a\xa8\xc8lH\x03\x0e\xaa";
        Qh[77] = 15894369557737;
        Qh[79] = "\x10\xccm\xb3w\x92\r\x93";
        Qh[74] = r16;
        Qh[75] = Qh[74](Qh[76], Qh[77]);
        Qh[72] = Qh[73][Qh[75]];
        Qh[77] = "\x05\x83\xff\xe4\x9eP\xd8";
        Qh[78] = 8854254604315;
        Qh[74] = r15;
        Qh[69] = "Toggle";
        Qh[75] = r16;
        Qh[76] = Qh[75](Qh[77], Qh[78]);
        Qh[73] = Qh[74][Qh[76]];
        Qh[80] = 11190502036570;
        Qh[69] = Qh[64][Qh[69]];
        Qh[74] = false;
        Qh[76] = r15;
        Qh[77] = r16;
        Qh[78] = Qh[77](Qh[79], Qh[80]);
        Qh[75] = Qh[76][Qh[78]];
        Qh[76] = function(arg1_97, ...)
            r76(arg1_97);
            return; 
        end;
        Qh[70] = {
            [Qh[71]] = Qh[72],
            [Qh[73]] = Qh[74],
            [Qh[75]] = Qh[76]
        };
        Qh[80] = 6413340134314;
        Qh[69] = Qh[69](Qh[64], Qh[70]);
        Qh[77] = 30819815258127;
        Qh[82] = 28602890777607;
        Qh[76] = 26929604161788;
        Qh[72] = r15;
        Qh[75] = "\x91\x82\xb1q\n";
        Qh[73] = r16;
        Qh[74] = Qh[73](Qh[75], Qh[76]);
        Qh[71] = Qh[72][Qh[74]];
        Qh[69] = "Input";
        Qh[78] = 10974818325494;
        Qh[76] = "\xf5\x17x\xeb\xce\xb1YP\x9b3\xb1\xc2u\x8a\xf6N\x04\x91 \x8f\xd9";
        Qh[73] = r15;
        Qh[74] = r16;
        Qh[75] = Qh[74](Qh[76], Qh[77]);
        Qh[81] = 34756455956280;
        Qh[77] = "\xc0-\xf9\x8c\xfc\x17\xb5";
        Qh[72] = Qh[73][Qh[75]];
        Qh[74] = r15;
        Qh[75] = r16;
        Qh[76] = Qh[75](Qh[77], Qh[78]);
        Qh[78] = "\x18m";
        Qh[79] = 23082523535868;
        Qh[73] = Qh[74][Qh[76]];
        Qh[75] = r15;
        Qh[76] = r16;
        Qh[77] = Qh[76](Qh[78], Qh[79]);
        Qh[79] = "3\x9c=G\x9c'\x98\x8b0\xcfI";
        Qh[74] = Qh[75][Qh[77]];
        Qh[69] = Qh[64][Qh[69]];
        Qh[76] = r15;
        Qh[77] = r16;
        Qh[78] = Qh[77](Qh[79], Qh[80]);
        Qh[75] = Qh[76][Qh[78]];
        Qh[80] = "\xdf3";
        Qh[77] = r15;
        Qh[78] = r16;
        Qh[79] = Qh[78](Qh[80], Qh[81]);
        Qh[81] = "\xfb\xae\x9e\xafNu\xcd\x15";
        Qh[76] = Qh[77][Qh[79]];
        Qh[78] = r15;
        Qh[79] = r16;
        Qh[80] = Qh[79](Qh[81], Qh[82]);
        Qh[77] = Qh[78][Qh[80]];
        Qh[82] = 5418237708763;
        Qh[78] = function(arg1_98, ...)
            j = tonumber(arg1_98);
            if j then
                H = "BHopSpeed";
                r42.BHopSpeed = H;
            end;
            return; 
        end;
        Qh[70] = {
            [Qh[71]] = Qh[72],
            [Qh[73]] = Qh[74],
            [Qh[75]] = Qh[76],
            [Qh[77]] = Qh[78]
        };
        Qh[81] = 35173794430971;
        Qh[69] = Qh[69](Qh[64], Qh[70]);
        Qh[79] = "`.\x8a\x00\x9f\xfe\x91\xa1";
        Qh[72] = r15;
        Qh[73] = r16;
        Qh[76] = 1496229839544;
        Qh[75] = "\xee\xa9\xf2\xc5U";
        Qh[80] = 35105640300507;
        Qh[77] = 4014561888077;
        Qh[74] = Qh[73](Qh[75], Qh[76]);
        Qh[71] = Qh[72][Qh[74]];
        Qh[69] = "Toggle";
        Qh[73] = r15;
        Qh[76] = "m\x83\x8f\x05\x12dE\xc6\x80(*\xbc\x7f``";
        Qh[74] = r16;
        Qh[78] = 17951170748583;
        Qh[75] = Qh[74](Qh[76], Qh[77]);
        Qh[72] = Qh[73][Qh[75]];
        Qh[74] = r15;
        Qh[77] = "\x7f\x7f\x07K\x0ch\x9b";
        Qh[75] = r16;
        Qh[76] = Qh[75](Qh[77], Qh[78]);
        Qh[73] = Qh[74][Qh[76]];
        Qh[76] = r15;
        Qh[74] = false;
        Qh[77] = r16;
        Qh[69] = Qh[64][Qh[69]];
        Qh[78] = Qh[77](Qh[79], Qh[80]);
        Qh[75] = Qh[76][Qh[78]];
        Qh[78] = 7111742328047;
        Qh[76] = function(arg1_99, ...)
            r79(arg1_99);
            return; 
        end;
        Qh[70] = {
            [Qh[71]] = Qh[72],
            [Qh[73]] = Qh[74],
            [Qh[75]] = Qh[76]
        };
        Qh[69] = Qh[69](Qh[64], Qh[70]);
        Qh[72] = r15;
        Qh[76] = 1277290381906;
        Qh[73] = r16;
        Qh[75] = "U*+\n@";
        Qh[80] = 9633764233606;
        Qh[74] = Qh[73](Qh[75], Qh[76]);
        Qh[76] = "\xaa\xf8[{[\xc7\x84\x85\xd2\xae:\xcaD\x07\x1c\xae\xcf\x05M\xf1\xe2\x9e\x08\xd6K\x1a8";
        Qh[77] = 23946838453135;
        Qh[71] = Qh[72][Qh[74]];
        Qh[73] = r15;
        Qh[74] = r16;
        Qh[75] = Qh[74](Qh[76], Qh[77]);
        Qh[72] = Qh[73][Qh[75]];
        Qh[77] = "\xfbO\x87\x0fT9\xfe";
        Qh[74] = r15;
        Qh[75] = r16;
        Qh[76] = Qh[75](Qh[77], Qh[78]);
        Qh[78] = "\xc4\\\x93\x1d";
        Qh[79] = 23861935041383;
        Qh[73] = Qh[74][Qh[76]];
        Qh[75] = r15;
        Qh[76] = r16;
        Qh[77] = Qh[76](Qh[78], Qh[79]);
        Qh[69] = "Input";
        Qh[74] = Qh[75][Qh[77]];
        Qh[76] = r15;
        Qh[77] = r16;
        Qh[79] = "\xf1\xe3lSX\xa3?N\xb0\xee6";
        Qh[78] = Qh[77](Qh[79], Qh[80]);
        Qh[75] = Qh[76][Qh[78]];
        Qh[77] = r15;
        Qh[80] = "YV\x00\r";
        Qh[78] = r16;
        Qh[79] = Qh[78](Qh[80], Qh[81]);
        Qh[76] = Qh[77][Qh[79]];
        Qh[81] = "\x12\xd9\x9ffY\xcf\xf8b";
        Qh[78] = r15;
        Qh[79] = r16;
        Qh[80] = Qh[79](Qh[81], Qh[82]);
        Qh[77] = Qh[78][Qh[80]];
        Qh[78] = function(arg1_100, ...)
            j = tonumber(arg1_100);
            if j then
                H = "Speed";
                r77.Speed = H;
            end;
            return; 
        end;
        Qh[70] = {
            [Qh[71]] = Qh[72],
            [Qh[73]] = Qh[74],
            [Qh[75]] = Qh[76],
            [Qh[77]] = Qh[78]
        };
        Qh[75] = ">\t\x04\xc8j";
        Qh[77] = 3415477814838;
        Qh[69] = Qh[64][Qh[69]];
        Qh[69] = Qh[69](Qh[64], Qh[70]);
        Qh[72] = r15;
        Qh[79] = "\xf2\x1b\xed\xb2\x80z\x8e\xec";
        Qh[78] = 29861784729169;
        Qh[73] = r16;
        Qh[76] = 15228853689267;
        Qh[74] = Qh[73](Qh[75], Qh[76]);
        Qh[71] = Qh[72][Qh[74]];
        Qh[73] = r15;
        Qh[74] = r16;
        Qh[76] = "4\xc0\xef(c\xb9\xa0\xccz\x98Vh";
        Qh[75] = Qh[74](Qh[76], Qh[77]);
        Qh[72] = Qh[73][Qh[75]];
        Qh[69] = "Toggle";
        Qh[77] = "\xce;\x88\xd4[\xb8\xcb";
        Qh[74] = r15;
        Qh[75] = r16;
        Qh[76] = Qh[75](Qh[77], Qh[78]);
        Qh[82] = 4905597044972;
        Qh[73] = Qh[74][Qh[76]];
        Qh[74] = false;
        Qh[76] = r15;
        Qh[77] = r16;
        Qh[80] = 16185863019889;
        Qh[69] = Qh[64][Qh[69]];
        Qh[78] = Qh[77](Qh[79], Qh[80]);
        Qh[75] = Qh[76][Qh[78]];
        Qh[76] = function(arg1_101, ...)
            if arg1_101 then
                v5 = not A[Qh[50]];
                if v5 then
                    v5 = r25.Stepped;
                    A[Qh[50]] = v5.Connect(v5, function(...)
                        if not r34.Character then
                            return;
                        end;
                        H = r34.Character;
                        v1 = H[2];
                        j = H[3];
                        H = "ipairs";
                        for j, Q in ipairs(H.GetDescendants(H)) do
                            e = j;
                            if Q.IsA(Q, "BasePart") then
                                Q.CanCollide = false;
                            end; 
                        end;
                        return; 
                    end);
                end;
            else
                if A[Qh[50]] then
                    v5 = A[Qh[50]];
                    v5.Disconnect(v5);
                    A[Qh[50]] = nil;
                end;
                return;
            end; 
        end;
        Qh[78] = 5168510617958;
        Qh[70] = {
            [Qh[71]] = Qh[72],
            [Qh[73]] = Qh[74],
            [Qh[75]] = Qh[76]
        };
        Qh[81] = "\xad\xdb\x82\x882\xdb\x8eo";
        Qh[69] = Qh[69](Qh[64], Qh[70]);
        Qh[72] = r15;
        Qh[77] = 5795550562954;
        Qh[76] = 337099882652;
        Qh[73] = r16;
        Qh[69] = "Button";
        Qh[69] = Qh[67][Qh[69]];
        Qh[75] = "\x11\xd6\xc8\x87\xb0";
        Qh[74] = Qh[73](Qh[75], Qh[76]);
        Qh[71] = Qh[72][Qh[74]];
        Qh[76] = "\xba\"\xf1\xf5:o\x85c\x8eU\x17\x0c\x1d\xa0\x94\x0c\x18~hx\xaa+\xbf\xc2\xd9\xfd\tZ\xf93g1";
        Qh[73] = r15;
        Qh[74] = r16;
        Qh[75] = Qh[74](Qh[76], Qh[77]);
        Qh[72] = Qh[73][Qh[75]];
        Qh[74] = r15;
        Qh[75] = r16;
        Qh[77] = "\xfe\x0b\xda\xf7\xa7\x8f'\x94";
        Qh[76] = Qh[75](Qh[77], Qh[78]);
        Qh[73] = Qh[74][Qh[76]];
        Qh[74] = function(...)
            A[Qh[36]]("\xd0\xa3\xd0\xb1\xd0\xb8\xd0\xb9\xd1\x86\xd0\xb0");
            return; 
        end;
        Qh[70] = {
            [Qh[71]] = Qh[72],
            [Qh[73]] = Qh[74]
        };
        Qh[77] = 28251034153827;
        Qh[76] = 16770368888449;
        Qh[69] = Qh[69](Qh[67], Qh[70]);
        Qh[72] = r15;
        Qh[73] = r16;
        Qh[75] = "\xa0]\xf5\xba7";
        Qh[74] = Qh[73](Qh[75], Qh[76]);
        Qh[71] = Qh[72][Qh[74]];
        Qh[73] = r15;
        Qh[76] = "\x8cs\xe7$\xbfQ\xebD\x90\x01\x07\xa4\x1b|\x03\xd9\xaf[\xdd\xa8\xa1\xe5\xf0\x152\xd7\xb3\xbd\x02hR&";
        Qh[74] = r16;
        Qh[75] = Qh[74](Qh[76], Qh[77]);
        Qh[72] = Qh[73][Qh[75]];
        Qh[74] = r15;
        Qh[69] = "Button";
        Qh[78] = 2385883169879;
        Qh[77] = "\xdd\x99=\xdd\xd8K\x8a\xf4";
        Qh[69] = Qh[67][Qh[69]];
        Qh[75] = r16;
        Qh[76] = Qh[75](Qh[77], Qh[78]);
        Qh[73] = Qh[74][Qh[76]];
        Qh[74] = function(...)
            A[Qh[36]]("\xd0\xa8\xd0\xb5\xd1\x80\xd0\xb8\xd1\x84");
            return; 
        end;
        Qh[83] = 2568552481964;
        Qh[76] = 21669552826218;
        Qh[70] = {
            [Qh[71]] = Qh[72],
            [Qh[73]] = Qh[74]
        };
        Qh[69] = Qh[69](Qh[67], Qh[70]);
        Qh[72] = r15;
        Qh[75] = "G\x18\xcd\x9bP";
        Qh[73] = r16;
        Qh[74] = Qh[73](Qh[75], Qh[76]);
        Qh[69] = "Button";
        Qh[76] = "L\xf7\xba^\xd5I=\xa7";
        Qh[71] = Qh[72][Qh[74]];
        Qh[77] = 24816259312931;
        Qh[73] = r15;
        Qh[74] = r16;
        Qh[75] = Qh[74](Qh[76], Qh[77]);
        Qh[80] = 26961405112586;
        Qh[79] = 17759950790734;
        Qh[72] = Qh[73][Qh[75]];
        Qh[77] = "\xd3\x13pHD<\n)";
        Qh[78] = 17838682579058;
        Qh[69] = Qh[68][Qh[69]];
        Qh[74] = r15;
        Qh[75] = r16;
        Qh[76] = Qh[75](Qh[77], Qh[78]);
        Qh[73] = Qh[74][Qh[76]];
        Qh[74] = function(...)
            r112();
            return; 
        end;
        Qh[70] = {
            [Qh[71]] = Qh[72],
            [Qh[73]] = Qh[74]
        };
        Qh[69] = Qh[69](Qh[68], Qh[70]);
        Qh[77] = 25684114730680;
        Qh[76] = "m\xf1\xea\xaaK";
        Qh[69] = r37;
        Qh[78] = 7583057956299;
        Qh[73] = r15;
        Qh[74] = r16;
        Qh[75] = Qh[74](Qh[76], Qh[77]);
        Qh[72] = Qh[73][Qh[75]];
        Qh[77] = "gN\xac";
        Qh[74] = r15;
        Qh[75] = r16;
        Qh[76] = Qh[75](Qh[77], Qh[78]);
        Qh[73] = Qh[74][Qh[76]];
        Qh[75] = r15;
        Qh[76] = r16;
        Qh[70] = "Tab";
        Qh[78] = "\x9b\xf5\x929";
        Qh[77] = Qh[76](Qh[78], Qh[79]);
        Qh[74] = Qh[75][Qh[77]];
        Qh[76] = r15;
        Qh[77] = r16;
        Qh[79] = "aso\x8d9";
        Qh[70] = Qh[69][Qh[70]];
        Qh[78] = Qh[77](Qh[79], Qh[80]);
        Qh[75] = Qh[76][Qh[78]];
        Qh[71] = {
            [Qh[72]] = Qh[73],
            [Qh[74]] = Qh[75]
        };
        Qh[70] = Qh[70](Qh[69], Qh[71]);
        Qh[76] = "\x98~\x88\x8c\xb8";
        Qh[73] = r15;
        Qh[79] = 15638968065138;
        Qh[77] = 31529896409434;
        Qh[74] = r16;
        Qh[75] = Qh[74](Qh[76], Qh[77]);
        Qh[72] = Qh[73][Qh[75]];
        Qh[74] = r15;
        Qh[77] = "\x90Z\xbc\x10\xaeP9\xbf\x18\xa6.\x8c7\xf5";
        Qh[69] = "Section";
        Qh[78] = 24871693118781;
        Qh[75] = r16;
        Qh[76] = Qh[75](Qh[77], Qh[78]);
        Qh[73] = Qh[74][Qh[76]];
        Qh[75] = r15;
        Qh[78] = "\xd9}\xa2\xe4";
        Qh[76] = r16;
        Qh[77] = Qh[76](Qh[78], Qh[79]);
        Qh[74] = Qh[75][Qh[77]];
        Qh[76] = r15;
        Qh[80] = 5979288537824;
        Qh[69] = Qh[70][Qh[69]];
        Qh[79] = "J\x01=\x8c";
        Qh[77] = r16;
        Qh[78] = Qh[77](Qh[79], Qh[80]);
        Qh[79] = 21057205773901;
        Qh[75] = Qh[76][Qh[78]];
        Qh[77] = "\xd1\xb8\xdb&\x0b";
        Qh[71] = {
            [Qh[72]] = Qh[73],
            [Qh[74]] = Qh[75]
        };
        Qh[69] = Qh[69](Qh[70], Qh[71]);
        Qh[74] = r15;
        Qh[75] = r16;
        Qh[78] = 24861115460920;
        Qh[76] = Qh[75](Qh[77], Qh[78]);
        Qh[78] = "\xf0\x83\x16.\xe4t\x08^\x05\xae:\xf2\xeb\xd1Qt\x8a\t\xfd\x86+\xc7~";
        Qh[73] = Qh[74][Qh[76]];
        Qh[71] = "Toggle";
        Qh[71] = Qh[69][Qh[71]];
        Qh[75] = r15;
        Qh[76] = r16;
        Qh[77] = Qh[76](Qh[78], Qh[79]);
        Qh[74] = Qh[75][Qh[77]];
        Qh[76] = r15;
        Qh[77] = r16;
        Qh[80] = 16955282710231;
        Qh[79] = "S\r\xdc}\x9f|\x17";
        Qh[78] = Qh[77](Qh[79], Qh[80]);
        Qh[75] = Qh[76][Qh[78]];
        Qh[76] = false;
        Qh[78] = r15;
        Qh[79] = r16;
        Qh[80] = Qh[79](Qh[81], Qh[82]);
        Qh[77] = Qh[78][Qh[80]];
        Qh[78] = function(arg1_102, ...)
            r68(arg1_102);
            return; 
        end;
        Qh[72] = {
            [Qh[73]] = Qh[74],
            [Qh[75]] = Qh[76],
            [Qh[77]] = Qh[78]
        };
        Qh[71] = Qh[71](Qh[69], Qh[72]);
        Qh[74] = r15;
        Qh[78] = 24472683588739;
        Qh[77] = "\x9ex\x17\xd8a";
        Qh[82] = 2167953392625;
        Qh[75] = r16;
        Qh[76] = Qh[75](Qh[77], Qh[78]);
        Qh[73] = Qh[74][Qh[76]];
        Qh[81] = "\xdai2\xa1l\xd6\xf7\xc7";
        Qh[79] = 11632695334184;
        Qh[75] = r15;
        Qh[80] = 21091460064861;
        Qh[78] = "\x83\xe3\x80Y\xa4\xf8W\x07\xa4\xf5\x04\x92\xc3s\x97\x8b";
        Qh[76] = r16;
        Qh[77] = Qh[76](Qh[78], Qh[79]);
        Qh[74] = Qh[75][Qh[77]];
        Qh[79] = "\x19\xd6\t\x94\xa7)\xed";
        Qh[76] = r15;
        Qh[77] = r16;
        Qh[71] = "Toggle";
        Qh[78] = Qh[77](Qh[79], Qh[80]);
        Qh[75] = Qh[76][Qh[78]];
        Qh[78] = r15;
        Qh[76] = false;
        Qh[71] = Qh[69][Qh[71]];
        Qh[79] = r16;
        Qh[80] = Qh[79](Qh[81], Qh[82]);
        Qh[77] = Qh[78][Qh[80]];
        Qh[79] = 12574305343199;
        Qh[78] = function(arg1_103, ...)
            r104(arg1_103);
            return; 
        end;
        Qh[72] = {
            [Qh[73]] = Qh[74],
            [Qh[75]] = Qh[76],
            [Qh[77]] = Qh[78]
        };
        Qh[78] = 9161604337834;
        Qh[71] = Qh[71](Qh[69], Qh[72]);
        Qh[87] = 12213713065527;
        Qh[74] = r15;
        Qh[80] = 31957374024225;
        Qh[75] = r16;
        Qh[77] = "OL\x16T\x1a";
        Qh[76] = Qh[75](Qh[77], Qh[78]);
        Qh[73] = Qh[74][Qh[76]];
        Qh[78] = "\xbb\x0c\n\x1c\xcc\xc1\xce\xddj\xa6h`\xd0\xcb\xbe\x91\x90K?0\x1a";
        Qh[75] = r15;
        Qh[82] = 12911405225852;
        Qh[76] = r16;
        Qh[77] = Qh[76](Qh[78], Qh[79]);
        Qh[74] = Qh[75][Qh[77]];
        Qh[76] = r15;
        Qh[79] = "\x89\x91e\x0c\xaa\x9c:";
        Qh[77] = r16;
        Qh[78] = Qh[77](Qh[79], Qh[80]);
        Qh[81] = 22584882882836;
        Qh[75] = Qh[76][Qh[78]];
        Qh[77] = r15;
        Qh[80] = "";
        Qh[78] = r16;
        Qh[79] = Qh[78](Qh[80], Qh[81]);
        Qh[81] = "%\x18\n\x8f\xdb\xbc\xe4T\x11\xa9\xe8";
        Qh[76] = Qh[77][Qh[79]];
        Qh[78] = r15;
        Qh[79] = r16;
        Qh[80] = Qh[79](Qh[81], Qh[82]);
        Qh[77] = Qh[78][Qh[80]];
        Qh[82] = " \x91\xae\xf2\x88\xfe>\xfd(\xd94\xca\xe65Y\xce\xf9\xe0\xba$I\x12\xd0\x8f\xf9\xfc,n\xf9\xc3\xda>\x8e\xd5";
        Qh[79] = r15;
        Qh[80] = r16;
        Qh[81] = Qh[80](Qh[82], Qh[83]);
        Qh[78] = Qh[79][Qh[81]];
        Qh[80] = r15;
        Qh[83] = "\x14?\xad\xb1\xd2\xe9\xe8s";
        Qh[81] = r16;
        Qh[71] = "Input";
        Qh[82] = Qh[81](Qh[83], Qh[84]);
        Qh[79] = Qh[80][Qh[82]];
        Qh[80] = function(arg1_104, ...)
            v1 = arg1_104;
            if r101[v1] then
                j = v1;
                r42.AnimPack = j;
                if r42.AnimPackEnabled then
                    r102(v1);
                    r38("\xd0\x90\xd0\xbd\xd0\xb8\xd0\xbc\xd0\xb0\xd1\x86\xd0\xb8\xd0\xb8", "\xd0\x9f\xd1\x80\xd0\xb8\xd0\xbc\xd0\xb5\xd0\xbd\xd0\xb5\xd0\xbd\xd0\xbe: " .. v1, 2);
                end;
            else
                r38("\xd0\x90\xd0\xbd\xd0\xb8\xd0\xbc\xd0\xb0\xd1\x86\xd0\xb8\xd0\xb8", "\xd0\x9f\xd0\xb0\xd1\x87\xd0\xba\xd0\xb0 \xd0\xbd\xd0\xb5 \xd0\xbd\xd0\xb0\xd0\xb9\xd0\xb4\xd0\xb5\xd0\xbd\xd0\xb0!", 2);
            end;
            return; 
        end;
        Qh[72] = {
            [Qh[73]] = Qh[74],
            [Qh[75]] = Qh[76],
            [Qh[77]] = Qh[78],
            [Qh[79]] = Qh[80]
        };
        Qh[71] = Qh[69][Qh[71]];
        Qh[71] = Qh[71](Qh[69], Qh[72]);
        Qh[71] = r37;
        Qh[75] = r15;
        Qh[83] = 26278185758668;
        Qh[76] = r16;
        Qh[78] = "\\.\xf2\xf5\xf4";
        Qh[79] = 901718639011;
        Qh[81] = 32989351017473;
        Qh[77] = Qh[76](Qh[78], Qh[79]);
        Qh[74] = Qh[75][Qh[77]];
        Qh[80] = 18335684600154;
        Qh[79] = "\xcc]\xec\x89\xea\xb1\xc7\xbd\xa2\xbc\xabQ";
        Qh[76] = r15;
        Qh[77] = r16;
        Qh[78] = Qh[77](Qh[79], Qh[80]);
        Qh[75] = Qh[76][Qh[78]];
        Qh[77] = r15;
        Qh[80] = "\r\xdb^\xfe";
        Qh[72] = "Tab";
        Qh[78] = r16;
        Qh[79] = Qh[78](Qh[80], Qh[81]);
        Qh[82] = 8484776595311;
        Qh[76] = Qh[77][Qh[79]];
        Qh[78] = r15;
        Qh[81] = "\x9b=\xb6XIGm\xaf\xef";
        Qh[79] = r16;
        Qh[80] = Qh[79](Qh[81], Qh[82]);
        Qh[79] = 911263285672;
        Qh[77] = Qh[78][Qh[80]];
        Qh[73] = {
            [Qh[74]] = Qh[75],
            [Qh[76]] = Qh[77]
        };
        Qh[72] = Qh[71][Qh[72]];
        Qh[72] = Qh[72](Qh[71], Qh[73]);
        Qh[75] = r15;
        Qh[76] = r16;
        Qh[78] = "\xab\x9a\n\x84\xb5";
        Qh[71] = "Section";
        Qh[80] = 24766384024844;
        Qh[77] = Qh[76](Qh[78], Qh[79]);
        Qh[71] = Qh[72][Qh[71]];
        Qh[79] = "\x08.\x98\xd2w\xefg\x93\xca\xf7\xd7\xa4";
        Qh[90] = 22604795783454;
        Qh[74] = Qh[75][Qh[77]];
        Qh[76] = r15;
        Qh[77] = r16;
        Qh[78] = Qh[77](Qh[79], Qh[80]);
        Qh[75] = Qh[76][Qh[78]];
        Qh[81] = 4830300899529;
        Qh[80] = "\xaf\xb5\xeb:";
        Qh[77] = r15;
        Qh[78] = r16;
        Qh[79] = Qh[78](Qh[80], Qh[81]);
        Qh[76] = Qh[77][Qh[79]];
        Qh[82] = 25782956420838;
        Qh[78] = r15;
        Qh[79] = r16;
        Qh[81] = "\x8f{\xc2\x82";
        Qh[80] = Qh[79](Qh[81], Qh[82]);
        Qh[77] = Qh[78][Qh[80]];
        Qh[79] = "\xec*#P\x9f";
        Qh[73] = {
            [Qh[74]] = Qh[75],
            [Qh[76]] = Qh[77]
        };
        Qh[80] = 5220979984767;
        Qh[82] = 15459699776542;
        Qh[71] = Qh[71](Qh[72], Qh[73]);
        Qh[76] = r15;
        Qh[77] = r16;
        Qh[78] = Qh[77](Qh[79], Qh[80]);
        Qh[73] = "Section";
        Qh[81] = 10809589437353;
        Qh[73] = Qh[72][Qh[73]];
        Qh[80] = "\x96B5?\xae2Y\x02[o\xe2\xb9";
        Qh[75] = Qh[76][Qh[78]];
        Qh[77] = r15;
        Qh[78] = r16;
        Qh[79] = Qh[78](Qh[80], Qh[81]);
        Qh[81] = "x\x83\r\xf2";
        Qh[76] = Qh[77][Qh[79]];
        Qh[78] = r15;
        Qh[79] = r16;
        Qh[80] = Qh[79](Qh[81], Qh[82]);
        Qh[77] = Qh[78][Qh[80]];
        Qh[79] = r15;
        Qh[80] = r16;
        Qh[82] = "|\xf8\xdf\x91\xd0";
        Qh[81] = Qh[80](Qh[82], Qh[83]);
        Qh[78] = Qh[79][Qh[81]];
        Qh[74] = {
            [Qh[75]] = Qh[76],
            [Qh[77]] = Qh[78]
        };
        Qh[80] = "}uO\xfb\x16";
        Qh[84] = "\x80\xdaE\x04\t\xa70\xdf";
        Qh[82] = 20365296821515;
        Qh[81] = 27764872163969;
        Qh[73] = Qh[73](Qh[72], Qh[74]);
        Qh[77] = r15;
        Qh[78] = r16;
        Qh[79] = Qh[78](Qh[80], Qh[81]);
        Qh[81] = "\x1f#\x9f\xf6H\x19\xaf\xc6\x0c\xc1\xe9\xd4\xec\xa2\xe9\xf3988VL\xccC\r\xb9r\xba\x04'";
        Qh[76] = Qh[77][Qh[79]];
        Qh[74] = "Toggle";
        Qh[78] = r15;
        Qh[79] = r16;
        Qh[80] = Qh[79](Qh[81], Qh[82]);
        Qh[74] = Qh[71][Qh[74]];
        Qh[83] = 15566497258576;
        Qh[77] = Qh[78][Qh[80]];
        Qh[79] = r15;
        Qh[80] = r16;
        Qh[82] = "U\xffr\xdcJ\x16H";
        Qh[81] = Qh[80](Qh[82], Qh[83]);
        Qh[78] = Qh[79][Qh[81]];
        Qh[81] = r15;
        Qh[79] = false;
        Qh[82] = r16;
        Qh[83] = Qh[82](Qh[84], Qh[85]);
        Qh[80] = Qh[81][Qh[83]];
        Qh[81] = function(arg1_105, ...)
            A[Qh[51]](arg1_105);
            return; 
        end;
        Qh[83] = 13374799730772;
        Qh[75] = {
            [Qh[76]] = Qh[77],
            [Qh[78]] = Qh[79],
            [Qh[80]] = Qh[81]
        };
        Qh[80] = "\x05\\D\xc2V";
        Qh[74] = Qh[74](Qh[71], Qh[75]);
        Qh[77] = r15;
        Qh[78] = r16;
        Qh[82] = 17734450651202;
        Qh[81] = 6272384797544;
        Qh[79] = Qh[78](Qh[80], Qh[81]);
        Qh[76] = Qh[77][Qh[79]];
        Qh[81] = "\xb4\xf4\"\xd2r\xef\x03-f\"\x81\xcd\xc4e\xbeYz";
        Qh[78] = r15;
        Qh[79] = r16;
        Qh[80] = Qh[79](Qh[81], Qh[82]);
        Qh[85] = 18846690140744;
        Qh[77] = Qh[78][Qh[80]];
        Qh[82] = "\xc8\xdc\xb2\xbd\xea q";
        Qh[79] = r15;
        Qh[80] = r16;
        Qh[81] = Qh[80](Qh[82], Qh[83]);
        Qh[78] = Qh[79][Qh[81]];
        Qh[74] = "Toggle";
        Qh[74] = Qh[71][Qh[74]];
        Qh[79] = false;
        Qh[81] = r15;
        Qh[84] = "\x8c/g\x04}\xa7Y\xc1";
        Qh[82] = r16;
        Qh[83] = Qh[82](Qh[84], Qh[85]);
        Qh[80] = Qh[81][Qh[83]];
        Qh[81] = function(arg1_106, ...)
            r114(arg1_106);
            return; 
        end;
        Qh[75] = {
            [Qh[76]] = Qh[77],
            [Qh[78]] = Qh[79],
            [Qh[80]] = Qh[81]
        };
        Qh[80] = "\xeaVU\x85L";
        Qh[74] = Qh[74](Qh[71], Qh[75]);
        Qh[77] = r15;
        Qh[81] = 14507452570211;
        Qh[78] = r16;
        Qh[82] = 775310524777;
        Qh[79] = Qh[78](Qh[80], Qh[81]);
        Qh[76] = Qh[77][Qh[79]];
        Qh[81] = "\x01\xd8\xab\x93\x7f\x08\x8d\xd5\xf3Wsdi\xde\xf9$\x00\xbb\xe7\xa8\x08\x01\x05\x81y/\xe7\xcb\xeah";
        Qh[78] = r15;
        Qh[74] = "Toggle";
        Qh[79] = r16;
        Qh[80] = Qh[79](Qh[81], Qh[82]);
        Qh[82] = "\xe6U|\xde\x9c\xaa\xde";
        Qh[77] = Qh[78][Qh[80]];
        Qh[74] = Qh[71][Qh[74]];
        Qh[83] = 31758095366596;
        Qh[79] = r15;
        Qh[85] = 17076005052175;
        Qh[80] = r16;
        Qh[81] = Qh[80](Qh[82], Qh[83]);
        Qh[78] = Qh[79][Qh[81]];
        Qh[79] = false;
        Qh[84] = "\x05S\x1e\x93\xe8\xe0X\xee";
        Qh[81] = r15;
        Qh[82] = r16;
        Qh[83] = Qh[82](Qh[84], Qh[85]);
        Qh[80] = Qh[81][Qh[83]];
        Qh[83] = 14164387486147;
        Qh[81] = function(arg1_107, ...)
            r42.AntiFlingEnabled = arg1_107;
            A[Qh[48]]();
            return; 
        end;
        Qh[75] = {
            [Qh[76]] = Qh[77],
            [Qh[78]] = Qh[79],
            [Qh[80]] = Qh[81]
        };
        Qh[74] = Qh[74](Qh[71], Qh[75]);
        Qh[80] = "-\xff\xac\x0c+";
        Qh[82] = 1230554317373;
        Qh[81] = 5457671522797;
        Qh[77] = r15;
        Qh[78] = r16;
        Qh[79] = Qh[78](Qh[80], Qh[81]);
        Qh[76] = Qh[77][Qh[79]];
        Qh[81] = "^\xbbi\xd8\xd3v\xa6\xbc\x8b8\xad\x05\x9e~\xa7\xe2\t\x15Q\x03\xf6\xac\xb4\xb4";
        Qh[78] = r15;
        Qh[79] = r16;
        Qh[80] = Qh[79](Qh[81], Qh[82]);
        Qh[77] = Qh[78][Qh[80]];
        Qh[85] = 16727502954093;
        Qh[74] = "Toggle";
        Qh[82] = "J\xa0\xa10:\xda\x1b";
        Qh[79] = r15;
        Qh[80] = r16;
        Qh[81] = Qh[80](Qh[82], Qh[83]);
        Qh[78] = Qh[79][Qh[81]];
        Qh[84] = "\xe7?qFp\xab\xb0\xac";
        Qh[74] = Qh[71][Qh[74]];
        Qh[79] = false;
        Qh[81] = r15;
        Qh[82] = r16;
        Qh[83] = Qh[82](Qh[84], Qh[85]);
        Qh[80] = Qh[81][Qh[83]];
        Qh[81] = function(arg1_108, ...)
            r116(arg1_108);
            return; 
        end;
        Qh[75] = {
            [Qh[76]] = Qh[77],
            [Qh[78]] = Qh[79],
            [Qh[80]] = Qh[81]
        };
        Qh[80] = "\x7fK\x8e\xba\\";
        Qh[74] = Qh[74](Qh[71], Qh[75]);
        Qh[81] = 1727556338468;
        Qh[77] = r15;
        Qh[82] = 21469623772941;
        Qh[78] = r16;
        Qh[79] = Qh[78](Qh[80], Qh[81]);
        Qh[76] = Qh[77][Qh[79]];
        Qh[84] = "\xe1# \xf5\x8d*\xd6=";
        Qh[78] = r15;
        Qh[79] = r16;
        Qh[81] = "\xb8\xda\xf1\x1c\x12\xf0\xffp\x90\xc1\x8eg\xd7\xa2'xs\x0b\xc1\xa1\xdb\x86\x00";
        Qh[83] = 17629221609489;
        Qh[80] = Qh[79](Qh[81], Qh[82]);
        Qh[77] = Qh[78][Qh[80]];
        Qh[79] = r15;
        Qh[82] = "\x95ZT\xba\x95\xbd\"";
        Qh[80] = r16;
        Qh[81] = Qh[80](Qh[82], Qh[83]);
        Qh[78] = Qh[79][Qh[81]];
        Qh[85] = 20063240955006;
        Qh[79] = false;
        Qh[81] = r15;
        Qh[82] = r16;
        Qh[83] = Qh[82](Qh[84], Qh[85]);
        Qh[82] = 26113998204800;
        Qh[80] = Qh[81][Qh[83]];
        Qh[81] = function(arg1_109, ...)
            r100(arg1_109);
            return; 
        end;
        Qh[75] = {
            [Qh[76]] = Qh[77],
            [Qh[78]] = Qh[79],
            [Qh[80]] = Qh[81]
        };
        Qh[83] = 20974504240679;
        Qh[74] = "Toggle";
        Qh[74] = Qh[71][Qh[74]];
        Qh[81] = 19274602685199;
        Qh[74] = Qh[74](Qh[71], Qh[75]);
        Qh[84] = "Q/\x05\xc5\xf96V7";
        Qh[80] = "Q\x0c\xce d";
        Qh[77] = r15;
        Qh[78] = r16;
        Qh[79] = Qh[78](Qh[80], Qh[81]);
        Qh[76] = Qh[77][Qh[79]];
        Qh[78] = r15;
        Qh[79] = r16;
        Qh[81] = "\xe8\x1b\x93\x85\xe50\xf7[!\x04\x06\x15$<\xa8\xc5";
        Qh[80] = Qh[79](Qh[81], Qh[82]);
        Qh[77] = Qh[78][Qh[80]];
        Qh[79] = r15;
        Qh[80] = r16;
        Qh[85] = 8856614604828;
        Qh[82] = "\xd2\xe7\xf3\xcc6\x02\x8d";
        Qh[81] = Qh[80](Qh[82], Qh[83]);
        Qh[78] = Qh[79][Qh[81]];
        Qh[81] = r15;
        Qh[74] = "Toggle";
        Qh[82] = r16;
        Qh[83] = Qh[82](Qh[84], Qh[85]);
        Qh[80] = Qh[81][Qh[83]];
        Qh[79] = false;
        Qh[74] = Qh[73][Qh[74]];
        Qh[81] = function(arg1_110, ...)
            v1 = arg1_110;
            r42.FovAimbotEnabled = v1;
            if v1 then
                A[Qh[34]]();
            end;
            A[Qh[35]]();
            return; 
        end;
        Qh[83] = 6569516452851;
        Qh[75] = {
            [Qh[76]] = Qh[77],
            [Qh[78]] = Qh[79],
            [Qh[80]] = Qh[81]
        };
        Qh[81] = 11573088556301;
        Qh[74] = Qh[74](Qh[73], Qh[75]);
        Qh[80] = "H\xb4\xd3\xbd\xf8";
        Qh[77] = r15;
        Qh[78] = r16;
        Qh[79] = Qh[78](Qh[80], Qh[81]);
        Qh[76] = Qh[77][Qh[79]];
        Qh[81] = "\xda\x0f\xd9\xa8\x04\xd5s\xa3\x86\x9e\xb4\x895\x8e\xd9\xab";
        Qh[82] = 14077594605979;
        Qh[78] = r15;
        Qh[79] = r16;
        Qh[80] = Qh[79](Qh[81], Qh[82]);
        Qh[77] = Qh[78][Qh[80]];
        Qh[79] = r15;
        Qh[80] = r16;
        Qh[84] = 27032788332844;
        Qh[82] = "\xc4\xede\x8e5\xcd\xf9";
        Qh[81] = Qh[80](Qh[82], Qh[83]);
        Qh[85] = 5171408259432;
        Qh[78] = Qh[79][Qh[81]];
        Qh[74] = "Input";
        Qh[80] = r15;
        Qh[81] = r16;
        Qh[83] = ">\x0e\x8d";
        Qh[82] = Qh[81](Qh[83], Qh[84]);
        Qh[79] = Qh[80][Qh[82]];
        Qh[84] = "I)\xd2\xe7x\x84\xd2v\xd6\x9b\xce";
        Qh[81] = r15;
        Qh[82] = r16;
        Qh[83] = Qh[82](Qh[84], Qh[85]);
        Qh[85] = "b\xeew";
        Qh[80] = Qh[81][Qh[83]];
        Qh[82] = r15;
        Qh[83] = r16;
        Qh[84] = Qh[83](Qh[85], Qh[86]);
        Qh[81] = Qh[82][Qh[84]];
        Qh[83] = r15;
        Qh[84] = r16;
        Qh[86] = "\xae4:\xc8\xba\x95\xeb\x11";
        Qh[74] = Qh[73][Qh[74]];
        Qh[85] = Qh[84](Qh[86], Qh[87]);
        Qh[88] = 31027128776816;
        Qh[82] = Qh[83][Qh[85]];
        Qh[83] = function(arg1_111, ...)
            j = tonumber(arg1_111);
            if j then
                r42.FovRadius = math.clamp(j, 10, 600);
                if r43.FovCircle then
                    r43.FovCircle.Radius = r42.FovRadius;
                end;
            end;
            return; 
        end;
        Qh[75] = {
            [Qh[76]] = Qh[77],
            [Qh[78]] = Qh[79],
            [Qh[80]] = Qh[81],
            [Qh[82]] = Qh[83]
        };
        Qh[85] = 34871441686382;
        Qh[74] = Qh[74](Qh[73], Qh[75]);
        Qh[77] = r15;
        Qh[81] = 17795436634206;
        Qh[78] = r16;
        Qh[80] = "\x93F\xd9\x19`";
        Qh[82] = 17513322176475;
        Qh[79] = Qh[78](Qh[80], Qh[81]);
        Qh[76] = Qh[77][Qh[79]];
        Qh[81] = "\xc08\xe6\xb0a\xdbj`)\x88\xedc}v=\n\xe5\xc3\xe8\xab\x1e\xb8\xfe1\x8a";
        Qh[78] = r15;
        Qh[79] = r16;
        Qh[80] = Qh[79](Qh[81], Qh[82]);
        Qh[77] = Qh[78][Qh[80]];
        Qh[79] = r15;
        Qh[83] = 33906511265196;
        Qh[80] = r16;
        Qh[82] = "J\n\x99\xe8\xa6N\xba";
        Qh[81] = Qh[80](Qh[82], Qh[83]);
        Qh[86] = 2645180253391;
        Qh[78] = Qh[79][Qh[81]];
        Qh[84] = "//\xda\x81O\xd2]\xe4";
        Qh[81] = r15;
        Qh[74] = "Toggle";
        Qh[74] = Qh[73][Qh[74]];
        Qh[82] = r16;
        Qh[83] = Qh[82](Qh[84], Qh[85]);
        Qh[79] = false;
        Qh[80] = Qh[81][Qh[83]];
        Qh[81] = function(arg1_112, ...)
            r95(arg1_112);
            return; 
        end;
        Qh[75] = {
            [Qh[76]] = Qh[77],
            [Qh[78]] = Qh[79],
            [Qh[80]] = Qh[81]
        };
        Qh[87] = 11307293267089;
        Qh[80] = ")\xf6\xeb\xc3z";
        Qh[74] = Qh[74](Qh[73], Qh[75]);
        Qh[77] = r15;
        Qh[78] = r16;
        Qh[84] = 25022041599363;
        Qh[81] = 10857654113215;
        Qh[79] = Qh[78](Qh[80], Qh[81]);
        Qh[76] = Qh[77][Qh[79]];
        Qh[78] = r15;
        Qh[74] = "Input";
        Qh[85] = 20907313636871;
        Qh[81] = "]\x83\x9a-2\x16\xc7\xa8\x1d\xb97\x07\x8f\xd1";
        Qh[82] = 4179810682778;
        Qh[79] = r16;
        Qh[80] = Qh[79](Qh[81], Qh[82]);
        Qh[77] = Qh[78][Qh[80]];
        Qh[79] = r15;
        Qh[80] = r16;
        Qh[82] = "u\x01\x08D\x86\xa5\x8e";
        Qh[83] = 917623914923;
        Qh[81] = Qh[80](Qh[82], Qh[83]);
        Qh[78] = Qh[79][Qh[81]];
        Qh[80] = r15;
        Qh[81] = r16;
        Qh[83] = " \xa3\x97";
        Qh[74] = Qh[73][Qh[74]];
        Qh[82] = Qh[81](Qh[83], Qh[84]);
        Qh[79] = Qh[80][Qh[82]];
        Qh[84] = "\xb1\xe8\x10\xd6\x14%*\x86\xdaz\xa8";
        Qh[81] = r15;
        Qh[82] = r16;
        Qh[83] = Qh[82](Qh[84], Qh[85]);
        Qh[80] = Qh[81][Qh[83]];
        Qh[82] = r15;
        Qh[83] = r16;
        Qh[85] = "\xe5 Q";
        Qh[84] = Qh[83](Qh[85], Qh[86]);
        Qh[81] = Qh[82][Qh[84]];
        Qh[83] = r15;
        Qh[84] = r16;
        Qh[86] = "\xd9Rk\xe4\xe3\x08:e";
        Qh[85] = Qh[84](Qh[86], Qh[87]);
        Qh[82] = Qh[83][Qh[85]];
        Qh[86] = 34308833279592;
        Qh[83] = function(arg1_113, ...)
            j = tonumber(arg1_113);
            if j then
                r42.SilentAimFov = math.clamp(j, 10, 600);
                if r43.SilentAimCircle then
                    r43.SilentAimCircle.Radius = r42.SilentAimFov;
                end;
            end;
            return; 
        end;
        Qh[75] = {
            [Qh[76]] = Qh[77],
            [Qh[78]] = Qh[79],
            [Qh[80]] = Qh[81],
            [Qh[82]] = Qh[83]
        };
        Qh[81] = 25226088377826;
        Qh[74] = Qh[74](Qh[73], Qh[75]);
        Qh[77] = r15;
        Qh[80] = "r\x13P$\x86";
        Qh[85] = 31795604830677;
        Qh[82] = 20071641916546;
        Qh[78] = r16;
        Qh[79] = Qh[78](Qh[80], Qh[81]);
        Qh[81] = "\x98Y\xc0\x11\xfb;\xa7\xd2\x0c\xfas\xb0";
        Qh[76] = Qh[77][Qh[79]];
        Qh[78] = r15;
        Qh[79] = r16;
        Qh[80] = Qh[79](Qh[81], Qh[82]);
        Qh[77] = Qh[78][Qh[80]];
        Qh[84] = "D\xe9\x01\xbe\x0f\xf8\xd0q";
        Qh[79] = r15;
        Qh[80] = r16;
        Qh[82] = "Gh\xba\xfb\xb9\x86\x19";
        Qh[83] = 18331733057880;
        Qh[87] = 7435496983942;
        Qh[74] = "Toggle";
        Qh[81] = Qh[80](Qh[82], Qh[83]);
        Qh[78] = Qh[79][Qh[81]];
        Qh[81] = r15;
        Qh[82] = r16;
        Qh[74] = Qh[73][Qh[74]];
        Qh[83] = Qh[82](Qh[84], Qh[85]);
        Qh[80] = Qh[81][Qh[83]];
        Qh[81] = function(arg1_114, ...)
            r108(arg1_114);
            return; 
        end;
        Qh[79] = false;
        Qh[75] = {
            [Qh[76]] = Qh[77],
            [Qh[78]] = Qh[79],
            [Qh[80]] = Qh[81]
        };
        Qh[74] = Qh[74](Qh[73], Qh[75]);
        Qh[83] = 30945621358666;
        Qh[77] = r15;
        Qh[80] = "\xfct\xe8\xec,";
        Qh[81] = 11920058160558;
        Qh[84] = 24133771226086;
        Qh[78] = r16;
        Qh[79] = Qh[78](Qh[80], Qh[81]);
        Qh[76] = Qh[77][Qh[79]];
        Qh[82] = 23503141333696;
        Qh[78] = r15;
        Qh[79] = r16;
        Qh[81] = ":\xfa9\x0b\xeaP\xef\xa3h\x1f\xad\x1a\x8a\xd1~E\xc9:\x8f\xd5Lcg\x98\xbf";
        Qh[80] = Qh[79](Qh[81], Qh[82]);
        Qh[77] = Qh[78][Qh[80]];
        Qh[82] = "\xec\xc57\xd6\xea\x89\xfb";
        Qh[74] = "Input";
        Qh[79] = r15;
        Qh[80] = r16;
        Qh[81] = Qh[80](Qh[82], Qh[83]);
        Qh[78] = Qh[79][Qh[81]];
        Qh[83] = "\xcb";
        Qh[80] = r15;
        Qh[81] = r16;
        Qh[82] = Qh[81](Qh[83], Qh[84]);
        Qh[79] = Qh[80][Qh[82]];
        Qh[81] = r15;
        Qh[85] = 9056674746489;
        Qh[82] = r16;
        Qh[84] = "\xb3V\x16u\xcd\xb8\xd1\xf5\x9e\x83x";
        Qh[83] = Qh[82](Qh[84], Qh[85]);
        Qh[85] = "P\xd4\xc8\xe2OP\xb2\xb7Og\xa5&:";
        Qh[80] = Qh[81][Qh[83]];
        Qh[82] = r15;
        Qh[83] = r16;
        Qh[84] = Qh[83](Qh[85], Qh[86]);
        Qh[81] = Qh[82][Qh[84]];
        Qh[83] = r15;
        Qh[74] = Qh[73][Qh[74]];
        Qh[86] = "\xec\x0c^\xd3\xf12\xafS";
        Qh[84] = r16;
        Qh[85] = Qh[84](Qh[86], Qh[87]);
        Qh[82] = Qh[83][Qh[85]];
        Qh[87] = "\nN\xf0x\xf6Z\xce<";
        Qh[83] = function(arg1_115, ...)
            v1 = arg1_115;
            j = v1;
            r42.TeleportGunKey = j;
            if r42.TeleportGunEnabled then
                r106(v1);
            end;
            return; 
        end;
        Qh[75] = {
            [Qh[76]] = Qh[77],
            [Qh[78]] = Qh[79],
            [Qh[80]] = Qh[81],
            [Qh[82]] = Qh[83]
        };
        Qh[74] = Qh[74](Qh[73], Qh[75]);
        Qh[74] = r37;
        Qh[85] = 8306052042523;
        Qh[78] = r15;
        Qh[79] = r16;
        Qh[81] = "\x8a\xfd\x9b\xdf\x98";
        Qh[83] = 30140095461075;
        Qh[82] = 9583912882542;
        Qh[80] = Qh[79](Qh[81], Qh[82]);
        Qh[77] = Qh[78][Qh[80]];
        Qh[79] = r15;
        Qh[80] = r16;
        Qh[82] = "\xb9\x89\x10\xd6\xd0\xef\xaa \x00\xf8\xf2Z\x1d\xf3\x0bvX";
        Qh[81] = Qh[80](Qh[82], Qh[83]);
        Qh[78] = Qh[79][Qh[81]];
        Qh[84] = 33375795018933;
        Qh[83] = "\xd0\xba\xc6\x04";
        Qh[80] = r15;
        Qh[81] = r16;
        Qh[82] = Qh[81](Qh[83], Qh[84]);
        Qh[84] = "s\x8f[\x8b";
        Qh[79] = Qh[80][Qh[82]];
        Qh[81] = r15;
        Qh[82] = r16;
        Qh[75] = "Tab";
        Qh[75] = Qh[74][Qh[75]];
        Qh[83] = Qh[82](Qh[84], Qh[85]);
        Qh[85] = 30744788973548;
        Qh[80] = Qh[81][Qh[83]];
        Qh[76] = {
            [Qh[77]] = Qh[78],
            [Qh[79]] = Qh[80]
        };
        Qh[81] = "\xdb\x96\xb2S\x0b";
        Qh[82] = 29827165058625;
        Qh[75] = Qh[75](Qh[74], Qh[76]);
        Qh[78] = r15;
        Qh[79] = r16;
        Qh[80] = Qh[79](Qh[81], Qh[82]);
        Qh[83] = 9049077026933;
        Qh[77] = Qh[78][Qh[80]];
        Qh[79] = r15;
        Qh[80] = r16;
        Qh[82] = "L\xfbF\xb3\x0fZ\x00s";
        Qh[81] = Qh[80](Qh[82], Qh[83]);
        Qh[83] = "\x7f\xa4E\x1b";
        Qh[78] = Qh[79][Qh[81]];
        Qh[84] = 12485862725302;
        Qh[80] = r15;
        Qh[81] = r16;
        Qh[82] = Qh[81](Qh[83], Qh[84]);
        Qh[79] = Qh[80][Qh[82]];
        Qh[81] = r15;
        Qh[84] = "\xc0Od\x84";
        Qh[74] = "Section";
        Qh[82] = r16;
        Qh[86] = 10194039788170;
        Qh[83] = Qh[82](Qh[84], Qh[85]);
        Qh[74] = Qh[75][Qh[74]];
        Qh[82] = "\xe3\x87Vl/";
        Qh[80] = Qh[81][Qh[83]];
        Qh[76] = {
            [Qh[77]] = Qh[78],
            [Qh[79]] = Qh[80]
        };
        Qh[74] = Qh[74](Qh[75], Qh[76]);
        Qh[84] = 33393176362173;
        Qh[76] = "Section";
        Qh[79] = r15;
        Qh[80] = r16;
        Qh[83] = 34071118626297;
        Qh[81] = Qh[80](Qh[82], Qh[83]);
        Qh[78] = Qh[79][Qh[81]];
        Qh[80] = r15;
        Qh[83] = "{\x99\xf3\x08\x87)\xb4\x9c\xaa\x97#\xb7\xd6\xdc\x0c\x13^\xeb";
        Qh[81] = r16;
        Qh[82] = Qh[81](Qh[83], Qh[84]);
        Qh[85] = 33389969226940;
        Qh[79] = Qh[80][Qh[82]];
        Qh[76] = Qh[75][Qh[76]];
        Qh[84] = "\x02z\xb0y";
        Qh[81] = r15;
        Qh[82] = r16;
        Qh[83] = Qh[82](Qh[84], Qh[85]);
        Qh[80] = Qh[81][Qh[83]];
        Qh[82] = r15;
        Qh[83] = r16;
        Qh[85] = "VZ\xd1\xed\xd4";
        Qh[84] = Qh[83](Qh[85], Qh[86]);
        Qh[85] = 20914018346506;
        Qh[81] = Qh[82][Qh[84]];
        Qh[84] = 1560967414486;
        Qh[77] = {
            [Qh[78]] = Qh[79],
            [Qh[80]] = Qh[81]
        };
        Qh[83] = "\x8bp[\xb4\xef";
        Qh[76] = Qh[76](Qh[75], Qh[77]);
        Qh[86] = 5591563635243;
        Qh[80] = r15;
        Qh[81] = r16;
        Qh[82] = Qh[81](Qh[83], Qh[84]);
        Qh[84] = "\x04\x9e\x8aj\x14\xa8\x8f}\xabL\x82\x80)\xd5no\xe1";
        Qh[79] = Qh[80][Qh[82]];
        Qh[81] = r15;
        Qh[82] = r16;
        Qh[83] = Qh[82](Qh[84], Qh[85]);
        Qh[85] = "\xd6\x98\"\xd7\xb4H\t";
        Qh[80] = Qh[81][Qh[83]];
        Qh[77] = "Toggle";
        Qh[82] = r15;
        Qh[83] = r16;
        Qh[84] = Qh[83](Qh[85], Qh[86]);
        Qh[77] = Qh[74][Qh[77]];
        Qh[81] = Qh[82][Qh[84]];
        Qh[82] = false;
        Qh[84] = r15;
        Qh[85] = r16;
        Qh[86] = Qh[85](Qh[87], Qh[88]);
        Qh[83] = Qh[84][Qh[86]];
        Qh[84] = function(arg1_116, ...)
            r42.AutoFarmEnabled = arg1_116;
            A[Qh[44]]();
            return; 
        end;
        Qh[78] = {
            [Qh[79]] = Qh[80],
            [Qh[81]] = Qh[82],
            [Qh[83]] = Qh[84]
        };
        Qh[77] = Qh[77](Qh[74], Qh[78]);
        Qh[80] = r15;
        Qh[84] = 9845702087144;
        Qh[83] = "f1h\xcb\xc8";
        Qh[81] = r16;
        Qh[82] = Qh[81](Qh[83], Qh[84]);
        Qh[86] = 14299841518082;
        Qh[84] = "\xdb\x1c`!\xf2\x10[E\xa6\xa0]\xc2=\xd9\xfa\x83\xb5\xad\x8f\xc7\xb9\x030";
        Qh[79] = Qh[80][Qh[82]];
        Qh[85] = 21068845049426;
        Qh[81] = r15;
        Qh[82] = r16;
        Qh[83] = Qh[82](Qh[84], Qh[85]);
        Qh[80] = Qh[81][Qh[83]];
        Qh[87] = "\x1b\xd9\x1e!h\x99Q\x1a";
        Qh[88] = 28177435161409;
        Qh[82] = r15;
        Qh[83] = r16;
        Qh[85] = "\xe9\xc4uQ\xf1\xf4\xac";
        Qh[84] = Qh[83](Qh[85], Qh[86]);
        Qh[81] = Qh[82][Qh[84]];
        Qh[77] = "Toggle";
        Qh[82] = true;
        Qh[84] = r15;
        Qh[85] = r16;
        Qh[86] = Qh[85](Qh[87], Qh[88]);
        Qh[77] = Qh[74][Qh[77]];
        Qh[83] = Qh[84][Qh[86]];
        Qh[84] = function(arg1_117, ...)
            r42.AutoRespawn = arg1_117;
            return; 
        end;
        Qh[78] = {
            [Qh[79]] = Qh[80],
            [Qh[81]] = Qh[82],
            [Qh[83]] = Qh[84]
        };
        Qh[84] = 26219899678641;
        Qh[77] = Qh[77](Qh[74], Qh[78]);
        Qh[80] = r15;
        Qh[83] = "O\x9f\xc8\xac}";
        Qh[88] = 25552879136378;
        Qh[81] = r16;
        Qh[82] = Qh[81](Qh[83], Qh[84]);
        Qh[79] = Qh[80][Qh[82]];
        Qh[85] = 16496204389889;
        Qh[84] = "\x8dM\xa1H\x1b\x1eJ\xd5\x14\xc9\xd6\xb14\x8a\x9d\\\xf1\xde\xe0X\xbd\x9a\xda\x99\xc4\xc92";
        Qh[81] = r15;
        Qh[82] = r16;
        Qh[83] = Qh[82](Qh[84], Qh[85]);
        Qh[80] = Qh[81][Qh[83]];
        Qh[86] = 13441327028339;
        Qh[85] = "\xbcf\x1bY\x80x\xb5";
        Qh[82] = r15;
        Qh[83] = r16;
        Qh[87] = 15169298799511;
        Qh[84] = Qh[83](Qh[85], Qh[86]);
        Qh[81] = Qh[82][Qh[84]];
        Qh[86] = "Y\x03";
        Qh[83] = r15;
        Qh[84] = r16;
        Qh[85] = Qh[84](Qh[86], Qh[87]);
        Qh[87] = "\x84>$\xa5\xde\xf6k\xa4\x9a)\x90";
        Qh[82] = Qh[83][Qh[85]];
        Qh[84] = r15;
        Qh[77] = "Input";
        Qh[85] = r16;
        Qh[86] = Qh[85](Qh[87], Qh[88]);
        Qh[77] = Qh[76][Qh[77]];
        Qh[83] = Qh[84][Qh[86]];
        Qh[85] = r15;
        Qh[88] = "\xcf\xa6";
        Qh[86] = r16;
        Qh[87] = Qh[86](Qh[88], Qh[89]);
        Qh[84] = Qh[85][Qh[87]];
        Qh[86] = r15;
        Qh[89] = "Aqn\x8aq\xe8\x92\x96";
        Qh[87] = r16;
        Qh[88] = Qh[87](Qh[89], Qh[90]);
        Qh[85] = Qh[86][Qh[88]];
        Qh[86] = function(arg1_118, ...)
            j = tonumber(arg1_118);
            if j then
                H = "AutoFarmSpeed";
                r42.AutoFarmSpeed = H;
            end;
            return; 
        end;
        Qh[88] = 5310388603304;
        Qh[78] = {
            [Qh[79]] = Qh[80],
            [Qh[81]] = Qh[82],
            [Qh[83]] = Qh[84],
            [Qh[85]] = Qh[86]
        };
        Qh[84] = 28428261045173;
        Qh[85] = 32188708665997;
        Qh[77] = Qh[77](Qh[76], Qh[78]);
        Qh[80] = r15;
        Qh[87] = 26619683958891;
        Qh[83] = "{\xa66po";
        Qh[81] = r16;
        Qh[82] = Qh[81](Qh[83], Qh[84]);
        Qh[79] = Qh[80][Qh[82]];
        Qh[84] = "/\xbb\x06\xfc\x00\x9d>\xde\xa1BJRm\x8dPa\x16XZ&\xff";
        Qh[81] = r15;
        Qh[82] = r16;
        Qh[83] = Qh[82](Qh[84], Qh[85]);
        Qh[80] = Qh[81][Qh[83]];
        Qh[85] = "\x8c\xe6\xf3`\xad\xfao";
        Qh[86] = 32853261335490;
        Qh[82] = r15;
        Qh[83] = r16;
        Qh[84] = Qh[83](Qh[85], Qh[86]);
        Qh[81] = Qh[82][Qh[84]];
        Qh[83] = r15;
        Qh[90] = 484388880609;
        Qh[84] = r16;
        Qh[86] = "\xda^";
        Qh[85] = Qh[84](Qh[86], Qh[87]);
        Qh[82] = Qh[83][Qh[85]];
        Qh[89] = 27496054288899;
        Qh[87] = "\xcc\x11G\x98\x9a\x1d\x94\x81\"\xc9\x1f";
        Qh[84] = r15;
        Qh[85] = r16;
        Qh[86] = Qh[85](Qh[87], Qh[88]);
        Qh[83] = Qh[84][Qh[86]];
        Qh[85] = r15;
        Qh[88] = ")=";
        Qh[77] = "Input";
        Qh[86] = r16;
        Qh[87] = Qh[86](Qh[88], Qh[89]);
        Qh[84] = Qh[85][Qh[87]];
        Qh[89] = "\x18\xd6\x9a\x054\xb0`\xcd";
        Qh[86] = r15;
        Qh[87] = r16;
        Qh[88] = Qh[87](Qh[89], Qh[90]);
        Qh[77] = Qh[76][Qh[77]];
        Qh[85] = Qh[86][Qh[88]];
        Qh[86] = function(arg1_119, ...)
            j = tonumber(arg1_119);
            if j then
                H = "AutoFarmCoinLimit";
                r42.AutoFarmCoinLimit = H;
            end;
            return; 
        end;
        Qh[78] = {
            [Qh[79]] = Qh[80],
            [Qh[81]] = Qh[82],
            [Qh[83]] = Qh[84],
            [Qh[85]] = Qh[86]
        };
        Qh[77] = Qh[77](Qh[76], Qh[78]);
        Qh[87] = 21262068278956;
        Qh[90] = 6991714520247;
        Qh[80] = r15;
        Qh[81] = r16;
        Qh[83] = "Z\x02=\x10\x9b";
        Qh[84] = 23056471157232;
        Qh[82] = Qh[81](Qh[83], Qh[84]);
        Qh[79] = Qh[80][Qh[82]];
        Qh[81] = r15;
        Qh[82] = r16;
        Qh[84] = "@\xdb\xc7\x14RJ\xc5\xe9\x17\x1d>\x8d(>{\xbc0l\xado\xa0\x80C\x96\xd8\xd0\xd2";
        Qh[85] = 34555507506907;
        Qh[83] = Qh[82](Qh[84], Qh[85]);
        Qh[85] = "O4\x16y6$\xad";
        Qh[80] = Qh[81][Qh[83]];
        Qh[82] = r15;
        Qh[86] = 16005055601948;
        Qh[83] = r16;
        Qh[84] = Qh[83](Qh[85], Qh[86]);
        Qh[86] = "S\xd5Z\xb4";
        Qh[81] = Qh[82][Qh[84]];
        Qh[88] = 9565175189862;
        Qh[83] = r15;
        Qh[84] = r16;
        Qh[85] = Qh[84](Qh[86], Qh[87]);
        Qh[82] = Qh[83][Qh[85]];
        Qh[84] = r15;
        Qh[85] = r16;
        Qh[87] = "\xff\x9d\x0c}\xd6\x8f8\x19R_S";
        Qh[86] = Qh[85](Qh[87], Qh[88]);
        Qh[88] = "\x97\x17\xaaU";
        Qh[83] = Qh[84][Qh[86]];
        Qh[85] = r15;
        Qh[86] = r16;
        Qh[77] = "Input";
        Qh[89] = 17566023016435;
        Qh[87] = Qh[86](Qh[88], Qh[89]);
        Qh[84] = Qh[85][Qh[87]];
        Qh[77] = Qh[76][Qh[77]];
        Qh[89] = "\x03O\xebL\xf9\x06\xfe\x1f";
        Qh[86] = r15;
        Qh[87] = r16;
        Qh[88] = Qh[87](Qh[89], Qh[90]);
        Qh[85] = Qh[86][Qh[88]];
        Qh[86] = function(arg1_120, ...)
            j = tonumber(arg1_120);
            if j then
                H = "AutoFarmCoinDelay";
                r42.AutoFarmCoinDelay = H;
            end;
            return; 
        end;
        Qh[78] = {
            [Qh[79]] = Qh[80],
            [Qh[81]] = Qh[82],
            [Qh[83]] = Qh[84],
            [Qh[85]] = Qh[86]
        };
        Qh[86] = 1219914121784;
        Qh[77] = Qh[77](Qh[76], Qh[78]);
        Qh[77] = r37;
        Qh[85] = 13408779688035;
        Qh[81] = r15;
        Qh[84] = "\xb9\x80\x92\n\xac";
        Qh[82] = r16;
        Qh[83] = Qh[82](Qh[84], Qh[85]);
        Qh[80] = Qh[81][Qh[83]];
        Qh[82] = r15;
        Qh[88] = 34477624737462;
        Qh[85] = "\xd9\xee\xe6\x97\x86\xe7\xa9e\xcfq\xb5#";
        Qh[83] = r16;
        Qh[84] = Qh[83](Qh[85], Qh[86]);
        Qh[87] = 25002440912250;
        Qh[86] = "yX\xb3\x00";
        Qh[90] = 24860215405880;
        Qh[81] = Qh[82][Qh[84]];
        Qh[83] = r15;
        Qh[84] = r16;
        Qh[85] = Qh[84](Qh[86], Qh[87]);
        Qh[82] = Qh[83][Qh[85]];
        Qh[84] = r15;
        Qh[85] = r16;
        Qh[87] = "\"a+l:";
        Qh[86] = Qh[85](Qh[87], Qh[88]);
        Qh[89] = "\xf7\x9cL\xa6o\x07_b";
        Qh[83] = Qh[84][Qh[86]];
        Qh[78] = "Tab";
        Qh[78] = Qh[77][Qh[78]];
        Qh[79] = {
            [Qh[80]] = Qh[81],
            [Qh[82]] = Qh[83]
        };
        Qh[84] = "\x02\x94\xbe\x9cy";
        Qh[85] = 15519755656250;
        Qh[78] = Qh[78](Qh[77], Qh[79]);
        Qh[81] = r15;
        Qh[82] = r16;
        Qh[83] = Qh[82](Qh[84], Qh[85]);
        Qh[86] = 17995503968443;
        Qh[80] = Qh[81][Qh[83]];
        Qh[82] = r15;
        Qh[83] = r16;
        Qh[85] = "S\xf8\xc9W)7\x9b\xb3\xe7?\x8c\xc7";
        Qh[87] = 16973330407135;
        Qh[84] = Qh[83](Qh[85], Qh[86]);
        Qh[81] = Qh[82][Qh[84]];
        Qh[83] = r15;
        Qh[86] = "\x08J\xaf\x13";
        Qh[77] = "Section";
        Qh[84] = r16;
        Qh[85] = Qh[84](Qh[86], Qh[87]);
        Qh[82] = Qh[83][Qh[85]];
        Qh[84] = r15;
        Qh[77] = Qh[78][Qh[77]];
        Qh[87] = "m~\x98h";
        Qh[88] = 6555283229676;
        Qh[85] = r16;
        Qh[86] = Qh[85](Qh[87], Qh[88]);
        Qh[83] = Qh[84][Qh[86]];
        Qh[79] = {
            [Qh[80]] = Qh[81],
            [Qh[82]] = Qh[83]
        };
        Qh[85] = "Cs\xe9\xddl";
        Qh[77] = Qh[77](Qh[78], Qh[79]);
        Qh[82] = r15;
        Qh[87] = 30414657451858;
        Qh[88] = 21724582045572;
        Qh[86] = 34491708358333;
        Qh[83] = r16;
        Qh[79] = "Toggle";
        Qh[84] = Qh[83](Qh[85], Qh[86]);
        Qh[81] = Qh[82][Qh[84]];
        Qh[83] = r15;
        Qh[84] = r16;
        Qh[86] = "\xb0\x88RM+\x87\xe0\xef\xe2\xa8\x89\xeab\xaf\x8a\xae\xbdU\xe9]\x7f#\x01\xad";
        Qh[85] = Qh[84](Qh[86], Qh[87]);
        Qh[82] = Qh[83][Qh[85]];
        Qh[84] = r15;
        Qh[85] = r16;
        Qh[87] = "Mie\x9a\x99\xc3\xe6";
        Qh[86] = Qh[85](Qh[87], Qh[88]);
        Qh[83] = Qh[84][Qh[86]];
        Qh[84] = false;
        Qh[86] = r15;
        Qh[87] = r16;
        Qh[79] = Qh[77][Qh[79]];
        Qh[88] = Qh[87](Qh[89], Qh[90]);
        Qh[85] = Qh[86][Qh[88]];
        Qh[86] = function(arg1_121, ...)
            r42.AntiAFKEnabled = arg1_121;
            A[Qh[37]]();
            return; 
        end;
        Qh[88] = 1039962489316;
        Qh[80] = {
            [Qh[81]] = Qh[82],
            [Qh[83]] = Qh[84],
            [Qh[85]] = Qh[86]
        };
        Qh[79] = Qh[79](Qh[77], Qh[80]);
        Qh[85] = "w\x07\x89\xe5\t";
        Qh[82] = r15;
        Qh[86] = 9145005723810;
        Qh[79] = "Button";
        Qh[87] = 27573381263911;
        Qh[83] = r16;
        Qh[84] = Qh[83](Qh[85], Qh[86]);
        Qh[86] = "e\xae\xfa\xf27t3^?\x12w\xb268Q\xff";
        Qh[81] = Qh[82][Qh[84]];
        Qh[83] = r15;
        Qh[84] = r16;
        Qh[85] = Qh[84](Qh[86], Qh[87]);
        Qh[82] = Qh[83][Qh[85]];
        Qh[79] = Qh[77][Qh[79]];
        Qh[84] = r15;
        Qh[87] = "\x81\xcfA\xd46\xffwA";
        Qh[85] = r16;
        Qh[86] = Qh[85](Qh[87], Qh[88]);
        Qh[83] = Qh[84][Qh[86]];
        Qh[84] = function(...)
            v5 = game;
            v3 = v5.GetService(v5, "TeleportService");
            v3.TeleportToPlaceInstance(v3, game.PlaceId, game.JobId, r34);
            return; 
        end;
        Qh[80] = {
            [Qh[81]] = Qh[82],
            [Qh[83]] = Qh[84]
        };
        Qh[79] = Qh[79](Qh[77], Qh[80]);
        Qh[80] = r24;
        Qh[82] = r15;
        Qh[85] = "v\xef\x9ebz\xf04o\xd2\x05\xee";
        Qh[83] = r16;
        Qh[86] = 11459730904280;
        Qh[84] = Qh[83](Qh[85], Qh[86]);
        Qh[81] = Qh[82][Qh[84]];
        Qh[85] = "^\x0ev\x7ft\x06Z3p\x92\x17\xf9nH";
        Qh[86] = 25160038297028;
        Qh[79] = Qh[80][Qh[81]];
        Qh[81] = function(arg1_122, ...)
            r168 = arg1_122;
            v5 = r168.CharacterAdded;
            v5.Connect(v5, function(...)
                task.wait(0.5);
                if r42.ChamsEnabled then
                    r117(r168);
                    r119(r168);
                end;
                if r42.TracersEnabled and r168 ~= r34 then
                    r132(r168);
                end;
                v1 = r42.MurderESP;
                if v1 or (r42.SheriffESP or r42.InnocentESP) then
                    v1 = r49(r168);
                    if r42.MurderESP and v1 == "\xd0\xa3\xd0\xb1\xd0\xb8\xd0\xb9\xd1\x86\xd0\xb0" then
                        r127(r168, r44.Murder);
                    else
                        if r42.SheriffESP and v1 == "\xd0\xa8\xd0\xb5\xd1\x80\xd0\xb8\xd1\x84" then
                            r127(r168, r44.Sheriff);
                        else
                            if r42.InnocentESP and v5(r168) == "\xd0\x9d\xd0\xb5\xd0\xb2\xd0\xb8\xd0\xbd\xd0\xbd\xd1\x8b\xd0\xb9" then
                                r127(r168, r44.Innocent);
                            end;
                        end;
                    end;
                end;
                if r42.AntiFlingEnabled and r168 ~= r34 then
                    task.spawn(function(...)
                        task.wait(0.5);
                        H = r16;
                        if r168.Character then
                            H = r168.Character;
                            j = H[3];
                            H = H[1];
                            for j, Q in H, ipairs(H.GetDescendants(H)) do
                                e = j;
                                if Q.IsA(Q, "BasePart") then
                                    Q.CanCollide = false;
                                end; 
                            end;
                        end;
                        return; 
                    end);
                end;
                return; 
            end);
            return; 
        end;
        Qh[80] = "Connect";
        Qh[80] = Qh[79][Qh[80]];
        Qh[80] = Qh[80](Qh[79], Qh[81]);
        Qh[80] = r24;
        Qh[82] = r15;
        Qh[83] = r16;
        Qh[84] = Qh[83](Qh[85], Qh[86]);
        Qh[81] = Qh[82][Qh[84]];
        Qh[79] = Qh[80][Qh[81]];
        Qh[81] = function(arg1_123, ...)
            r169 = arg1_123;
            r43.ChamsPartsList[r169.UserId] = nil;
            r43.Highlights[r169.UserId] = nil;
            if r43.Tracers[r169.UserId] then
                pcall(function(...)
                    v5 = r43.Tracers[r169.UserId];
                    v5.Remove(v5);
                    return; 
                end);
                r43.Tracers[r169.UserId] = nil;
            end;
            return; 
        end;
        Qh[80] = "Connect";
        Qh[80] = Qh[79][Qh[80]];
        Qh[80] = Qh[80](Qh[79], Qh[81]);
        Qh[80] = r34;
        Qh[82] = r15;
        Qh[85] = "Fn\xe7\xf2'\xb0H;\x1d\xc7\x1c\x14f\xba";
        Qh[83] = r16;
        Qh[86] = 19276376990480;
        Qh[84] = Qh[83](Qh[85], Qh[86]);
        Qh[81] = Qh[82][Qh[84]];
        Qh[79] = Qh[80][Qh[81]];
        Qh[80] = "Connect";
        Qh[80] = Qh[79][Qh[80]];
        Qh[81] = function(...)
            task.wait(0.5);
            r130();
            r125();
            A[Qh[1]]();
            r43.ChamsPartsList = {};
            H = r24;
            j = H[3];
            H = H[1];
            for j, Q in H, ipairs(H.GetPlayers(H)) do
                e = j;
                if r42.ChamsEnabled then
                    r117(Q);
                    r119(Q);
                end;
                if r42.TracersEnabled and Q ~= r34 then
                    r132(Q);
                end;
                v4 = r42.MurderESP or (r42.SheriffESP or r42.InnocentESP);
                if v4 then
                    v4 = r49(Q);
                    if r42.MurderESP and v4 == "\xd0\xa3\xd0\xb1\xd0\xb8\xd0\xb9\xd1\x86\xd0\xb0" then
                        r127(Q, r44.Murder);
                    else
                        if r42.SheriffESP and v4 == "\xd0\xa8\xd0\xb5\xd1\x80\xd0\xb8\xd1\x84" then
                            r127(Q, r44.Sheriff);
                        else
                            if r42.InnocentESP and v5(Q) == "\xd0\x9d\xd0\xb5\xd0\xb2\xd0\xb8\xd0\xbd\xd0\xbd\xd1\x8b\xd0\xb9" then
                                r127(Q, r44.Innocent);
                            end;
                        end;
                    end;
                end; 
            end;
            A[Qh[29]]();
            r43.JumpTracking = {
                ["wasJumping"] = false
            };
            if r42.Trails then
                task.wait(.1);
                A[Qh[2]]();
            end;
            if r42.FlyEnabled then
                task.wait(0.5);
                r70();
            end;
            if r42.BHopEnabled then
                r73();
            end;
            if r42.AntiFlingEnabled then
                A[Qh[48]]();
            end;
            if r42.FovAimbotEnabled then
                A[Qh[35]]();
            end;
            if r42.ShootButtonEnabled then
                A[Qh[49]]();
            end;
            if r42.WallHopEnabled then
                r115();
            end;
            if r42.SheriffAutoShootEnabled then
                r114(true);
            end;
            if r42.TexturePackEnabled then
                task.wait(.3);
                A[Qh[18]]();
            end;
            if r42.ChinaHatEnabled then
                task.wait(.2);
                if r42.ChinaHatStyle == "Classic" then
                    A[Qh[24]](r34.Character);
                end;
            end;
            if r42.AuraEnabled then
                task.wait(.3);
                r66();
            end;
            if r42.OrbizEnabled then
                task.wait(.2);
                r80();
            end;
            if r42.SilentAimEnabled then
                task.wait(.2);
                r92();
                setupSilentAim();
            end;
            if r42.KillAllEnabled then
                task.wait(.2);
                if not r43.KillAllRemote then
                    r96();
                end;
                r99();
            end;
            if r42.AnimPackEnabled and r42.AnimPack ~= "" then
                task.wait(.3);
                r102(r42.AnimPack);
            end;
            return; 
        end;
        Qh[86] = 30352429545269;
        Qh[80] = Qh[80](Qh[79], Qh[81]);
        Qh[79] = A[Qh[53]];
        Qh[80] = Qh[79]();
        Qh[79] = Qh[54]();
        Qh[79] = A[Qh[34]];
        Qh[80] = Qh[79]();
        Qh[79] = A[Qh[21]];
        Qh[80] = Qh[79]();
        Qh[79] = r92;
        Qh[80] = Qh[79]();
        Qh[87] = 2385452090454;
        Qh[85] = "\x01\xe0\xf4K\t5\xad\xae\x8f";
        Qh[79] = r38;
        Qh[82] = r15;
        Qh[83] = r16;
        Qh[84] = Qh[83](Qh[85], Qh[86]);
        Qh[81] = Qh[82][Qh[84]];
        Qh[83] = r15;
        Qh[86] = "-\x150\xe5\x1a*\xc3)\x8b\xd2\xe5>\x84\xd8\x9d\xd0\x80\xf3\xc9iY\\\xa3\xe8sJA]\xebHL\x9b4\x83";
        Qh[84] = r16;
        Qh[85] = Qh[84](Qh[86], Qh[87]);
        Qh[86] = 1951594300300;
        Qh[82] = Qh[83][Qh[85]];
        Qh[83] = 4;
        Qh[85] = "\xa4w\xe1\xc9\xd2#\xb5>\xe5";
        Qh[80] = Qh[79](Qh[81], Qh[82], Qh[83]);
        Qh[80] = r34;
        Qh[82] = r15;
        Qh[83] = r16;
        Qh[84] = Qh[83](Qh[85], Qh[86]);
        Qh[81] = Qh[82][Qh[84]];
        Qh[85] = "\x82\xbd.L{\x96\x9a\x10\xb0\xe4I\x19\xa2\xda2\x95";
        Qh[86] = 23712364489505;
        Qh[79] = Qh[80][Qh[81]];
        Qh[82] = r15;
        Qh[83] = r16;
        Qh[80] = "FindFirstChild";
        Qh[84] = Qh[83](Qh[85], Qh[86]);
        Qh[81] = Qh[82][Qh[84]];
        Qh[80] = Qh[79][Qh[80]];
        Qh[80] = Qh[80](Qh[79], Qh[81]);
        if Qh[80] then
            Qh[79] = "Destroy";
            Qh[79] = Qh[80][Qh[79]];
            Qh[79] = Qh[79](Qh[80]);
        end;
        Qh[82] = "Instance";
        Qh[98] = 27680316551769;
        Qh[87] = 30408761227088;
        Qh[81] = Env[Qh[82]];
        Qh[86] = "\xce\x92}";
        Qh[83] = r15;
        Qh[84] = r16;
        Qh[85] = Qh[84](Qh[86], Qh[87]);
        Qh[89] = "\x10\xa5\x0f\xd1i\xec\x92t\x85\x8e\x8b\t\xab\x13";
        Qh[86] = "\x9e\xad\x06P3\xfaBR\x04";
        Qh[87] = 27030591729963;
        Qh[82] = Qh[83][Qh[85]];
        Qh[79] = Qh[81][Qh[82]];
        Qh[83] = r15;
        Qh[84] = r16;
        Qh[13] = nil;
        Qh[85] = Qh[84](Qh[86], Qh[87]);
        Qh[44] = nil;
        Qh[82] = Qh[83][Qh[85]];
        Qh[99] = 3279545239031;
        Qh[81] = Qh[79](Qh[82]);
        Qh[86] = 13368672000081;
        Qh[82] = r15;
        Qh[85] = "\xa0Q\"e";
        Qh[83] = r16;
        Qh[84] = Qh[83](Qh[85], Qh[86]);
        Qh[79] = Qh[82][Qh[84]];
        Qh[83] = r15;
        Qh[84] = r16;
        Qh[87] = 6738601299009;
        Qh[86] = "\xe2D/~\xea\xf9\xb0\xb9\"}\x15\xfb\xe0(\x8f=";
        Qh[85] = Qh[84](Qh[86], Qh[87]);
        Qh[82] = Qh[83][Qh[85]];
        Qh[90] = 592449306899;
        Qh[81][Qh[79]] = Qh[82];
        Qh[86] = 16825549315739;
        Qh[85] = "w\xcd\x9f\x0b\xdc\x16\xd5\x83\x9a\x18)\xfc";
        Qh[82] = r15;
        Qh[83] = r16;
        Qh[49] = nil;
        Qh[84] = Qh[83](Qh[85], Qh[86]);
        Qh[79] = Qh[82][Qh[84]];
        Qh[86] = 16875304771250;
        Qh[85] = "6\xc5\x10\x85\xec\x19U\x9a\xf6D\x83\xdb\xbb)";
        Qh[82] = false;
        Qh[81][Qh[79]] = Qh[82];
        Qh[82] = r15;
        Qh[83] = r16;
        Qh[84] = Qh[83](Qh[85], Qh[86]);
        Qh[79] = Qh[82][Qh[84]];
        Qh[85] = "`\xb5\x87@4X\x93\xd2aA!\x1ah\xf7";
        Qh[51] = nil;
        Qh[82] = true;
        Qh[81][Qh[79]] = Qh[82];
        Qh[82] = r15;
        Qh[86] = 29887751861853;
        Qh[83] = r16;
        Qh[84] = Qh[83](Qh[85], Qh[86]);
        Qh[79] = Qh[82][Qh[84]];
        Qh[85] = "Enum";
        Qh[84] = Env[Qh[85]];
        Qh[86] = r15;
        Qh[87] = r16;
        Qh[88] = Qh[87](Qh[89], Qh[90]);
        Qh[91] = 27152368742755;
        Qh[85] = Qh[86][Qh[88]];
        Qh[88] = "\xdbxl\xf4a\x0b\x90";
        Qh[89] = 4473942411299;
        Qh[83] = Qh[84][Qh[85]];
        Qh[85] = r15;
        Qh[86] = r16;
        Qh[87] = Qh[86](Qh[88], Qh[89]);
        Qh[86] = 21818267314095;
        Qh[84] = Qh[85][Qh[87]];
        Qh[85] = "\xdc_\xedPD\xf3\xa6\x03\x10\xc5\x0e\xde";
        Qh[82] = Qh[83][Qh[84]];
        Qh[81][Qh[79]] = Qh[82];
        Qh[82] = r15;
        Qh[83] = r16;
        Qh[84] = Qh[83](Qh[85], Qh[86]);
        Qh[86] = 23592329538282;
        Qh[88] = "\x1c\x87\x9e\xa8c\xfa\x7f\xbb\x9b";
        Qh[79] = Qh[82][Qh[84]];
        Qh[82] = 999;
        Qh[85] = "\xed4\xd71\x91U";
        Qh[81][Qh[79]] = Qh[82];
        Qh[82] = r15;
        Qh[83] = r16;
        Qh[84] = Qh[83](Qh[85], Qh[86]);
        Qh[83] = "WaitForChild";
        Qh[89] = 2852704978224;
        Qh[79] = Qh[82][Qh[84]];
        Qh[82] = r34;
        Qh[85] = r15;
        Qh[86] = r16;
        Qh[87] = Qh[86](Qh[88], Qh[89]);
        Qh[84] = Qh[85][Qh[87]];
        Qh[83] = Qh[82][Qh[83]];
        Qh[83] = Qh[83](Qh[82], Qh[84]);
        Qh[81][Qh[79]] = Qh[83];
        Qh[83] = "Instance";
        Qh[82] = Env[Qh[83]];
        Qh[84] = r15;
        Qh[46] = nil;
        Qh[88] = 19610493608875;
        Qh[87] = "\x84\xd6\x1b";
        Qh[85] = r16;
        Qh[86] = Qh[85](Qh[87], Qh[88]);
        Qh[83] = Qh[84][Qh[86]];
        Qh[79] = Qh[82][Qh[83]];
        Qh[87] = "\x7f\x87\x9baD";
        Qh[84] = r15;
        Qh[85] = r16;
        Qh[88] = 7914762456677;
        Qh[86] = Qh[85](Qh[87], Qh[88]);
        Qh[83] = Qh[84][Qh[86]];
        Qh[82] = Qh[79](Qh[83]);
        Qh[79] = 187;
        A[Qh[79]] = Qh[82];
        Qh[87] = "\xfa(px";
        Qh[82] = A[Qh[79]];
        Qh[56] = nil;
        Qh[88] = 10507054895900;
        Qh[84] = r15;
        Qh[85] = r16;
        Qh[94] = 18404486504826;
        Qh[86] = Qh[85](Qh[87], Qh[88]);
        Qh[83] = Qh[84][Qh[86]];
        Qh[88] = "\xe4k\xcdH\x8d\xb0";
        Qh[89] = 5132771281238;
        Qh[85] = r15;
        Qh[86] = r16;
        Qh[87] = Qh[86](Qh[88], Qh[89]);
        Qh[84] = Qh[85][Qh[87]];
        Qh[87] = "\xff\x083\xa9";
        Qh[88] = 29795588634162;
        Qh[82][Qh[83]] = Qh[84];
        Qh[82] = A[Qh[79]];
        Qh[84] = r15;
        Qh[85] = r16;
        Qh[86] = Qh[85](Qh[87], Qh[88]);
        Qh[83] = Qh[84][Qh[86]];
        Qh[86] = "UDim2";
        Qh[85] = Env[Qh[86]];
        Qh[87] = r15;
        Qh[21] = nil;
        Qh[37] = nil;
        Qh[90] = "K@\xf4";
        Qh[88] = r16;
        Qh[89] = Qh[88](Qh[90], Qh[91]);
        Qh[91] = 24026412837812;
        Qh[86] = Qh[87][Qh[89]];
        Qh[84] = Qh[85][Qh[86]];
        Qh[88] = 0;
        Qh[90] = "u\x86\xbe";
        Qh[87] = 150;
        Qh[89] = 30;
        Qh[86] = 0;
        Qh[63] = nil;
        Qh[85] = Qh[84](Qh[86], Qh[87], Qh[88], Qh[89]);
        Qh[88] = 20440253900078;
        Qh[87] = "\xca&\xed+\x1d\x95\xda\xcf";
        Qh[82][Qh[83]] = Qh[85];
        Qh[82] = A[Qh[79]];
        Qh[84] = r15;
        Qh[85] = r16;
        Qh[86] = Qh[85](Qh[87], Qh[88]);
        Qh[83] = Qh[84][Qh[86]];
        Qh[86] = "UDim2";
        Qh[85] = Env[Qh[86]];
        Qh[87] = r15;
        Qh[88] = r16;
        Qh[89] = Qh[88](Qh[90], Qh[91]);
        Qh[86] = Qh[87][Qh[89]];
        Qh[87] = -160;
        Qh[89] = 10;
        Qh[84] = Qh[85][Qh[86]];
        Qh[88] = 0;
        Qh[86] = 1;
        Qh[85] = Qh[84](Qh[86], Qh[87], Qh[88], Qh[89]);
        Qh[82][Qh[83]] = Qh[85];
        Qh[90] = "\xb2wAI\"\xdb\xc3";
        Qh[82] = A[Qh[79]];
        Qh[88] = 32839406664636;
        Qh[53] = nil;
        Qh[84] = r15;
        Qh[91] = 20030482703471;
        Qh[85] = r16;
        Qh[87] = "\x8f|lT\xbf\x0f\x0b\x1c6\xcdh*\xe6j\xa1\xa4";
        Qh[86] = Qh[85](Qh[87], Qh[88]);
        Qh[83] = Qh[84][Qh[86]];
        Qh[86] = "Color3";
        Qh[85] = Env[Qh[86]];
        Qh[87] = r15;
        Qh[88] = r16;
        Qh[89] = Qh[88](Qh[90], Qh[91]);
        Qh[93] = 18599269327316;
        Qh[88] = 20;
        Qh[86] = Qh[87][Qh[89]];
        Qh[84] = Qh[85][Qh[86]];
        Qh[86] = 15;
        Qh[87] = 15;
        Qh[85] = Qh[84](Qh[86], Qh[87], Qh[88]);
        Qh[82][Qh[83]] = Qh[85];
        Qh[82] = A[Qh[79]];
        Qh[88] = 12740914435884;
        Qh[84] = r15;
        Qh[87] = "\xb2\xa6l\xb0h\xb0 \t\x93q\x07\xf2\xa7#;\xb7\xb2o\x8fY\x03\xc9";
        Qh[85] = r16;
        Qh[86] = Qh[85](Qh[87], Qh[88]);
        Qh[83] = Qh[84][Qh[86]];
        Qh[84] = .05;
        Qh[82][Qh[83]] = Qh[84];
        Qh[61] = nil;
        Qh[82] = A[Qh[79]];
        Qh[88] = 14174212020680;
        Qh[84] = r15;
        Qh[85] = r16;
        Qh[90] = "\x15\xe3\xb1";
        Qh[87] = "\xcd\x8a\xe0\xb9\xf0\\9=\x7f\xd2\x9b~\xf1\xc3z";
        Qh[86] = Qh[85](Qh[87], Qh[88]);
        Qh[83] = Qh[84][Qh[86]];
        Qh[84] = 0;
        Qh[82][Qh[83]] = Qh[84];
        Qh[88] = 28077079376658;
        Qh[87] = "\xeaB\\\t\xd8~\xf7\xc7\xf9\xfa\xa0\x11\x8b\xed\x07X";
        Qh[82] = A[Qh[79]];
        Qh[84] = r15;
        Qh[85] = r16;
        Qh[96] = 15179553872796;
        Qh[86] = Qh[85](Qh[87], Qh[88]);
        Qh[83] = Qh[84][Qh[86]];
        Qh[84] = true;
        Qh[42] = nil;
        Qh[82][Qh[83]] = Qh[84];
        Qh[82] = A[Qh[79]];
        Qh[84] = r15;
        Qh[89] = 15688510299273;
        Qh[87] = "Z\xff\x80\xd7<G";
        Qh[88] = 13303058192434;
        Qh[85] = r16;
        Qh[92] = 6832733883501;
        Qh[86] = Qh[85](Qh[87], Qh[88]);
        Qh[87] = "\x914\x0c\xd7\xa7\x82";
        Qh[83] = Qh[84][Qh[86]];
        Qh[84] = Qh[81];
        Qh[88] = 14671782337200;
        Qh[82][Qh[83]] = Qh[84];
        Qh[82] = A[Qh[79]];
        Qh[26] = nil;
        Qh[84] = r15;
        Qh[85] = r16;
        Qh[86] = Qh[85](Qh[87], Qh[88]);
        Qh[36] = nil;
        Qh[91] = 10912899421145;
        Qh[83] = Qh[84][Qh[86]];
        Qh[84] = true;
        Qh[82][Qh[83]] = Qh[84];
        Qh[88] = 23245136816712;
        Qh[82] = A[Qh[79]];
        Qh[84] = r15;
        Qh[87] = "\xac\x11\xad7\x0b\xdfv\xb8\x9d";
        Qh[85] = r16;
        Qh[86] = Qh[85](Qh[87], Qh[88]);
        Qh[97] = 22502126463214;
        Qh[83] = Qh[84][Qh[86]];
        Qh[84] = true;
        Qh[82][Qh[83]] = Qh[84];
        Qh[84] = "Instance";
        Qh[64] = nil;
        Qh[83] = Env[Qh[84]];
        Qh[85] = r15;
        Qh[86] = r16;
        Qh[88] = "J=\x8c";
        Qh[87] = Qh[86](Qh[88], Qh[89]);
        Qh[84] = Qh[85][Qh[87]];
        Qh[82] = Qh[83][Qh[84]];
        Qh[89] = 16623376637500;
        Qh[85] = r15;
        Qh[86] = r16;
        Qh[88] = "\xcfEc\x8fC\xbdGD";
        Qh[87] = Qh[86](Qh[88], Qh[89]);
        Qh[84] = Qh[85][Qh[87]];
        Qh[87] = "2NX\x10;\x1a/\xd1\xd3\xb3`5";
        Qh[83] = Qh[82](Qh[84]);
        Qh[84] = r15;
        Qh[85] = r16;
        Qh[88] = 11773129217386;
        Qh[86] = Qh[85](Qh[87], Qh[88]);
        Qh[82] = Qh[84][Qh[86]];
        Qh[86] = "UDim";
        Qh[62] = nil;
        Qh[85] = Env[Qh[86]];
        Qh[87] = r15;
        Qh[88] = r16;
        Qh[89] = Qh[88](Qh[90], Qh[91]);
        Qh[88] = 8469596262247;
        Qh[86] = Qh[87][Qh[89]];
        Qh[87] = 0;
        Qh[84] = Qh[85][Qh[86]];
        Qh[90] = 25141801217467;
        Qh[12] = nil;
        Qh[86] = 1;
        Qh[85] = Qh[84](Qh[86], Qh[87]);
        Qh[83][Qh[82]] = Qh[85];
        Qh[89] = "D\x05\xeb";
        Qh[87] = "\r|\xf8\x8a\x08\xa2";
        Qh[84] = r15;
        Qh[85] = r16;
        Qh[86] = Qh[85](Qh[87], Qh[88]);
        Qh[91] = "\xd4\x08f\xba[\xfa#";
        Qh[82] = Qh[84][Qh[86]];
        Qh[85] = "Instance";
        Qh[84] = A[Qh[79]];
        Qh[83][Qh[82]] = Qh[84];
        Qh[84] = Env[Qh[85]];
        Qh[86] = r15;
        Qh[87] = r16;
        Qh[88] = Qh[87](Qh[89], Qh[90]);
        Qh[85] = Qh[86][Qh[88]];
        Qh[82] = Qh[84][Qh[85]];
        Qh[89] = ",^\xc2\x89>i\x8d\x90";
        Qh[90] = 17651500736539;
        Qh[86] = r15;
        Qh[87] = r16;
        Qh[88] = Qh[87](Qh[89], Qh[90]);
        Qh[85] = Qh[86][Qh[88]];
        Qh[84] = Qh[82](Qh[85]);
        Qh[89] = 25295145594370;
        Qh[85] = r15;
        Qh[86] = r16;
        Qh[88] = "\r!\xc9\xabx";
        Qh[87] = Qh[86](Qh[88], Qh[89]);
        Qh[82] = Qh[85][Qh[87]];
        Qh[87] = "Color3";
        Qh[86] = Env[Qh[87]];
        Qh[88] = r15;
        Qh[89] = r16;
        Qh[90] = Qh[89](Qh[91], Qh[92]);
        Qh[87] = Qh[88][Qh[90]];
        Qh[85] = Qh[86][Qh[87]];
        Qh[88] = 40;
        Qh[92] = "\xd9\x97\xbd";
        Qh[89] = 50;
        Qh[87] = 40;
        Qh[86] = Qh[85](Qh[87], Qh[88], Qh[89]);
        Qh[84][Qh[82]] = Qh[86];
        Qh[85] = r15;
        Qh[89] = 12354880493177;
        Qh[86] = r16;
        Qh[91] = 34173147807273;
        Qh[88] = "\xbc\xe7\xdf\x0c\x07A\xc0Ta";
        Qh[87] = Qh[86](Qh[88], Qh[89]);
        Qh[88] = "@\xf2\x1c\x8c\xe5\xe5q\xdd\xe14\xb1\xf4";
        Qh[89] = 25887594901270;
        Qh[82] = Qh[85][Qh[87]];
        Qh[85] = 1;
        Qh[84][Qh[82]] = Qh[85];
        Qh[90] = "(T\x15";
        Qh[85] = r15;
        Qh[86] = r16;
        Qh[87] = Qh[86](Qh[88], Qh[89]);
        Qh[82] = Qh[85][Qh[87]];
        Qh[89] = 11306676311185;
        Qh[85] = 0.5;
        Qh[84][Qh[82]] = Qh[85];
        Qh[85] = r15;
        Qh[86] = r16;
        Qh[88] = "\xf3\xbd,\x1e\x15\x93";
        Qh[87] = Qh[86](Qh[88], Qh[89]);
        Qh[82] = Qh[85][Qh[87]];
        Qh[85] = A[Qh[79]];
        Qh[84][Qh[82]] = Qh[85];
        Qh[86] = "Instance";
        Qh[85] = Env[Qh[86]];
        Qh[87] = r15;
        Qh[88] = r16;
        Qh[89] = Qh[88](Qh[90], Qh[91]);
        Qh[86] = Qh[87][Qh[89]];
        Qh[82] = Qh[85][Qh[86]];
        Qh[91] = 14295552334336;
        Qh[90] = "7\xfa\xbdj\xafp\xffi\xaf";
        Qh[87] = r15;
        Qh[88] = r16;
        Qh[89] = Qh[88](Qh[90], Qh[91]);
        Qh[86] = Qh[87][Qh[89]];
        Qh[85] = Qh[82](Qh[86]);
        Qh[86] = r15;
        Qh[90] = 14159381289409;
        Qh[89] = "\x9d\x90\xcf\xd9";
        Qh[87] = r16;
        Qh[88] = Qh[87](Qh[89], Qh[90]);
        Qh[82] = Qh[86][Qh[88]];
        Qh[88] = "UDim2";
        Qh[87] = Env[Qh[88]];
        Qh[89] = r15;
        Qh[90] = r16;
        Qh[91] = Qh[90](Qh[92], Qh[93]);
        Qh[29] = nil;
        Qh[88] = Qh[89][Qh[91]];
        Qh[89] = 48;
        Qh[91] = 0;
        Qh[86] = Qh[87][Qh[88]];
        Qh[88] = 0;
        Qh[90] = 1;
        Qh[92] = "\xfcp\xc3";
        Qh[87] = Qh[86](Qh[88], Qh[89], Qh[90], Qh[91]);
        Qh[85][Qh[82]] = Qh[87];
        Qh[90] = 22210314791014;
        Qh[89] = "2\xb4\x03Q\r\xe91\xca";
        Qh[86] = r15;
        Qh[87] = r16;
        Qh[88] = Qh[87](Qh[89], Qh[90]);
        Qh[82] = Qh[86][Qh[88]];
        Qh[88] = "UDim2";
        Qh[87] = Env[Qh[88]];
        Qh[89] = r15;
        Qh[90] = r16;
        Qh[93] = 24666436185310;
        Qh[91] = Qh[90](Qh[92], Qh[93]);
        Qh[88] = Qh[89][Qh[91]];
        Qh[86] = Qh[87][Qh[88]];
        Qh[16] = nil;
        Qh[90] = 0;
        Qh[88] = 0;
        Qh[91] = 0;
        Qh[89] = 4;
        Qh[87] = Qh[86](Qh[88], Qh[89], Qh[90], Qh[91]);
        Qh[85][Qh[82]] = Qh[87];
        Qh[86] = r15;
        Qh[90] = 23732040608555;
        Qh[89] = ".\xd9\x04\x8d\xb6\x84?\n\xb5\xb5# s\xdfG\n\xadZ\xe5\"\x1c$";
        Qh[87] = r16;
        Qh[88] = Qh[87](Qh[89], Qh[90]);
        Qh[82] = Qh[86][Qh[88]];
        Qh[90] = 16821531336345;
        Qh[89] = "\xc7\xb64\xdf";
        Qh[86] = 1;
        Qh[85][Qh[82]] = Qh[86];
        Qh[86] = r15;
        Qh[87] = r16;
        Qh[88] = Qh[87](Qh[89], Qh[90]);
        Qh[45] = nil;
        Qh[91] = 16634432822850;
        Qh[30] = nil;
        Qh[82] = Qh[86][Qh[88]];
        Qh[87] = r15;
        Qh[88] = r16;
        Qh[90] = "X\xed\xba{\xeb\xab";
        Qh[89] = Qh[88](Qh[90], Qh[91]);
        Qh[100] = 597669888278;
        Qh[86] = Qh[87][Qh[89]];
        Qh[85][Qh[82]] = Qh[86];
        Qh[93] = 5663572068941;
        Qh[90] = 8987922419801;
        Qh[86] = r15;
        Qh[87] = r16;
        Qh[89] = "\xa0\xb6\x8eO\x86\xed\x16\xf6\xd0\x10";
        Qh[92] = "Tc`:$\xd4\xc6";
        Qh[88] = Qh[87](Qh[89], Qh[90]);
        Qh[82] = Qh[86][Qh[88]];
        Qh[88] = "Color3";
        Qh[2] = nil;
        Qh[87] = Env[Qh[88]];
        Qh[80] = nil;
        Qh[89] = r15;
        Qh[90] = r16;
        Qh[91] = Qh[90](Qh[92], Qh[93]);
        Qh[88] = Qh[89][Qh[91]];
        Qh[86] = Qh[87][Qh[88]];
        Qh[88] = 255;
        Qh[89] = 255;
        Qh[90] = 255;
        Qh[87] = Qh[86](Qh[88], Qh[89], Qh[90]);
        Qh[85][Qh[82]] = Qh[87];
        Qh[86] = r15;
        Qh[89] = "1\xaf\x1a\x11\xc9\xa0g\xd5";
        Qh[20] = nil;
        Qh[90] = 14289467398654;
        Qh[87] = r16;
        Qh[88] = Qh[87](Qh[89], Qh[90]);
        Qh[82] = Qh[86][Qh[88]];
        Qh[86] = 12;
        Qh[90] = 29018405123272;
        Qh[85][Qh[82]] = Qh[86];
        Qh[86] = r15;
        Qh[87] = r16;
        Qh[89] = "@\xefn\x9e";
        Qh[88] = Qh[87](Qh[89], Qh[90]);
        Qh[82] = Qh[86][Qh[88]];
        Qh[89] = "Enum";
        Qh[93] = "\x92\x88W\x0e";
        Qh[88] = Env[Qh[89]];
        Qh[90] = r15;
        Qh[91] = r16;
        Qh[92] = Qh[91](Qh[93], Qh[94]);
        Qh[89] = Qh[90][Qh[92]];
        Qh[87] = Qh[88][Qh[89]];
        Qh[14] = nil;
        Qh[93] = 28463679419334;
        Qh[89] = r15;
        Qh[92] = "@\x0f\xa6\x86s\x8f\xc2n\x9e\x12";
        Qh[90] = r16;
        Qh[91] = Qh[90](Qh[92], Qh[93]);
        Qh[88] = Qh[89][Qh[91]];
        Qh[86] = Qh[87][Qh[88]];
        Qh[94] = 31707544713644;
        Qh[90] = 21911112394715;
        Qh[89] = "\x02\xdf\x80\xde\xf3\xc2O\xf8\xa29\xac\xde\\\xbe";
        Qh[85][Qh[82]] = Qh[86];
        Qh[86] = r15;
        Qh[87] = r16;
        Qh[88] = Qh[87](Qh[89], Qh[90]);
        Qh[72] = nil;
        Qh[93] = ".\xa47\xd5\xd5\xe5\x87o\x86\xe1\xc8\x98C\x02";
        Qh[82] = Qh[86][Qh[88]];
        Qh[89] = "Enum";
        Qh[88] = Env[Qh[89]];
        Qh[90] = r15;
        Qh[91] = r16;
        Qh[92] = Qh[91](Qh[93], Qh[94]);
        Qh[93] = 7951089651318;
        Qh[89] = Qh[90][Qh[92]];
        Qh[94] = 12211682907702;
        Qh[87] = Qh[88][Qh[89]];
        Qh[89] = r15;
        Qh[92] = "\x9f\x15\xbeh\xef(";
        Qh[90] = r16;
        Qh[91] = Qh[90](Qh[92], Qh[93]);
        Qh[88] = Qh[89][Qh[91]];
        Qh[86] = Qh[87][Qh[88]];
        Qh[85][Qh[82]] = Qh[86];
        Qh[86] = r15;
        Qh[90] = 9971877106211;
        Qh[89] = "\xa5\"\x1d\xab\xff\xd1\xa4\x01p\xccNm\x9d\xef";
        Qh[87] = r16;
        Qh[88] = Qh[87](Qh[89], Qh[90]);
        Qh[82] = Qh[86][Qh[88]];
        Qh[93] = "\x1fY(\xd5\x1d\x8fC\x98\xddZ\xa9b\x15\xdd";
        Qh[89] = "Enum";
        Qh[88] = Env[Qh[89]];
        Qh[90] = r15;
        Qh[91] = r16;
        Qh[92] = Qh[91](Qh[93], Qh[94]);
        Qh[89] = Qh[90][Qh[92]];
        Qh[87] = Qh[88][Qh[89]];
        Qh[92] = "\xcei\xd0\xa8\xca5";
        Qh[89] = r15;
        Qh[93] = 24574466288819;
        Qh[90] = r16;
        Qh[91] = Qh[90](Qh[92], Qh[93]);
        Qh[88] = Qh[89][Qh[91]];
        Qh[86] = Qh[87][Qh[88]];
        Qh[85][Qh[82]] = Qh[86];
        Qh[86] = r15;
        Qh[69] = nil;
        Qh[89] = "'\xa9#C\xd8\xde";
        Qh[93] = "\xa9\xceu";
        Qh[90] = 21745006323597;
        Qh[94] = 5591710960171;
        Qh[91] = "g\xcfp";
        Qh[87] = r16;
        Qh[92] = 23124582328848;
        Qh[88] = Qh[87](Qh[89], Qh[90]);
        Qh[82] = Qh[86][Qh[88]];
        Qh[27] = nil;
        Qh[86] = A[Qh[79]];
        Qh[85][Qh[82]] = Qh[86];
        Qh[87] = "Instance";
        Qh[86] = Env[Qh[87]];
        Qh[88] = r15;
        Qh[52] = nil;
        Qh[89] = r16;
        Qh[90] = Qh[89](Qh[91], Qh[92]);
        Qh[87] = Qh[88][Qh[90]];
        Qh[82] = Qh[86][Qh[87]];
        Qh[91] = "!\xb4\xe4G\xd3";
        Qh[92] = 33044062567451;
        Qh[88] = r15;
        Qh[89] = r16;
        Qh[90] = Qh[89](Qh[91], Qh[92]);
        Qh[87] = Qh[88][Qh[90]];
        Qh[91] = 11702435452233;
        Qh[90] = "\xf6\xf4\x83\x81";
        Qh[86] = Qh[82](Qh[87]);
        Qh[40] = nil;
        Qh[87] = r15;
        Qh[88] = r16;
        Qh[89] = Qh[88](Qh[90], Qh[91]);
        Qh[50] = nil;
        Qh[82] = Qh[87][Qh[89]];
        Qh[89] = "UDim2";
        Qh[88] = Env[Qh[89]];
        Qh[90] = r15;
        Qh[91] = r16;
        Qh[92] = Qh[91](Qh[93], Qh[94]);
        Qh[89] = Qh[90][Qh[92]];
        Qh[87] = Qh[88][Qh[89]];
        Qh[92] = 16;
        Qh[91] = 0;
        Qh[89] = 0;
        Qh[90] = 1;
        Qh[71] = nil;
        Qh[43] = nil;
        Qh[88] = Qh[87](Qh[89], Qh[90], Qh[91], Qh[92]);
        Qh[86][Qh[82]] = Qh[88];
        Qh[93] = "6}:";
        Qh[87] = r15;
        Qh[91] = 23154836056606;
        Qh[88] = r16;
        Qh[90] = "(?\xe6\x10l\xcf\xab\xf8";
        Qh[94] = 18535169335735;
        Qh[89] = Qh[88](Qh[90], Qh[91]);
        Qh[82] = Qh[87][Qh[89]];
        Qh[89] = "UDim2";
        Qh[88] = Env[Qh[89]];
        Qh[90] = r15;
        Qh[91] = r16;
        Qh[92] = Qh[91](Qh[93], Qh[94]);
        Qh[91] = 0.5;
        Qh[89] = Qh[90][Qh[92]];
        Qh[74] = nil;
        Qh[94] = 13858058852661;
        Qh[92] = -8;
        Qh[87] = Qh[88][Qh[89]];
        Qh[90] = 56;
        Qh[3] = nil;
        Qh[89] = 0;
        Qh[93] = "\x12\xe5|\x95\x00\xe9\xfa";
        Qh[88] = Qh[87](Qh[89], Qh[90], Qh[91], Qh[92]);
        Qh[11] = nil;
        Qh[86][Qh[82]] = Qh[88];
        Qh[87] = r15;
        Qh[88] = r16;
        Qh[91] = 17946591453349;
        Qh[90] = "\xd3\xc6,\xf8\xc1\x1a\xfeO\t`\xa5\x8d\xc7\xe0\xb8d";
        Qh[89] = Qh[88](Qh[90], Qh[91]);
        Qh[95] = "Z\xd2M";
        Qh[82] = Qh[87][Qh[89]];
        Qh[89] = "Color3";
        Qh[88] = Env[Qh[89]];
        Qh[90] = r15;
        Qh[91] = r16;
        Qh[92] = Qh[91](Qh[93], Qh[94]);
        Qh[89] = Qh[90][Qh[92]];
        Qh[90] = 60;
        Qh[87] = Qh[88][Qh[89]];
        Qh[89] = 60;
        Qh[91] = 70;
        Qh[88] = Qh[87](Qh[89], Qh[90], Qh[91]);
        Qh[91] = 29841845646920;
        Qh[86][Qh[82]] = Qh[88];
        Qh[87] = r15;
        Qh[88] = r16;
        Qh[90] = "w\xf5\xf17\x0e\xb3\x89x\x93{\xf88\x92\xc6\xc7";
        Qh[89] = Qh[88](Qh[90], Qh[91]);
        Qh[90] = "\xb7\xed\xbd\xef\xf9\xae";
        Qh[91] = 16935367171790;
        Qh[82] = Qh[87][Qh[89]];
        Qh[87] = 0;
        Qh[93] = 28153611186998;
        Qh[86][Qh[82]] = Qh[87];
        Qh[87] = r15;
        Qh[88] = r16;
        Qh[89] = Qh[88](Qh[90], Qh[91]);
        Qh[82] = Qh[87][Qh[89]];
        Qh[87] = A[Qh[79]];
        Qh[86][Qh[82]] = Qh[87];
        Qh[88] = "Instance";
        Qh[87] = Env[Qh[88]];
        Qh[78] = nil;
        Qh[89] = r15;
        Qh[92] = "Y-\x89";
        Qh[90] = r16;
        Qh[91] = Qh[90](Qh[92], Qh[93]);
        Qh[88] = Qh[89][Qh[91]];
        Qh[82] = Qh[87][Qh[88]];
        Qh[92] = "\x8bs\xfc\xe5]\xee\xadGP";
        Qh[89] = r15;
        Qh[93] = 8816854831113;
        Qh[90] = r16;
        Qh[91] = Qh[90](Qh[92], Qh[93]);
        Qh[88] = Qh[89][Qh[91]];
        Qh[5] = nil;
        Qh[87] = Qh[82](Qh[88]);
        Qh[93] = 350264393891;
        Qh[82] = 188;
        A[Qh[82]] = Qh[87];
        Qh[58] = nil;
        Qh[87] = A[Qh[82]];
        Qh[89] = r15;
        Qh[90] = r16;
        Qh[92] = ";]\x17\xc0";
        Qh[91] = Qh[90](Qh[92], Qh[93]);
        Qh[88] = Qh[89][Qh[91]];
        Qh[91] = "UDim2";
        Qh[90] = Env[Qh[91]];
        Qh[92] = r15;
        Qh[93] = r16;
        Qh[94] = Qh[93](Qh[95], Qh[96]);
        Qh[31] = nil;
        Qh[93] = 1;
        Qh[65] = nil;
        Qh[91] = Qh[92][Qh[94]];
        Qh[94] = 0;
        Qh[9] = nil;
        Qh[89] = Qh[90][Qh[91]];
        Qh[91] = 0;
        Qh[92] = 38;
        Qh[86] = nil;
        Qh[90] = Qh[89](Qh[91], Qh[92], Qh[93], Qh[94]);
        Qh[87][Qh[88]] = Qh[90];
        Qh[87] = A[Qh[82]];
        Qh[93] = 33483291016423;
        Qh[89] = r15;
        Qh[83] = nil;
        Qh[92] = "%O\xaa\xeb\x12\xf1\xf8\xf4";
        Qh[90] = r16;
        Qh[8] = nil;
        Qh[91] = Qh[90](Qh[92], Qh[93]);
        Qh[88] = Qh[89][Qh[91]];
        Qh[95] = ",\xd1\xbb";
        Qh[91] = "UDim2";
        Qh[90] = Env[Qh[91]];
        Qh[92] = r15;
        Qh[84] = nil;
        Qh[93] = r16;
        Qh[96] = 24082305002446;
        Qh[10] = nil;
        Qh[94] = Qh[93](Qh[95], Qh[96]);
        Qh[91] = Qh[92][Qh[94]];
        Qh[89] = Qh[90][Qh[91]];
        Qh[93] = 0;
        Qh[92] = 61;
        Qh[94] = 0;
        Qh[91] = 0;
        Qh[90] = Qh[89](Qh[91], Qh[92], Qh[93], Qh[94]);
        Qh[87][Qh[88]] = Qh[90];
        Qh[93] = 32001085209141;
        Qh[87] = A[Qh[82]];
        Qh[89] = r15;
        Qh[92] = "(\xc4\xa4qXV\r\xbc\x81\x16\xe4\xb4\xafh\x0cz\xb3\xcf~\x11\xa2l";
        Qh[90] = r16;
        Qh[91] = Qh[90](Qh[92], Qh[93]);
        Qh[88] = Qh[89][Qh[91]];
        Qh[89] = 1;
        Qh[93] = 14933351750441;
        Qh[87][Qh[88]] = Qh[89];
        Qh[94] = 33070227422247;
        Qh[92] = "0XR\xe1";
        Qh[87] = A[Qh[82]];
        Qh[89] = r15;
        Qh[90] = r16;
        Qh[91] = Qh[90](Qh[92], Qh[93]);
        Qh[93] = ")\xd0";
        Qh[88] = Qh[89][Qh[91]];
        Qh[90] = r15;
        Qh[91] = r16;
        Qh[92] = Qh[91](Qh[93], Qh[94]);
        Qh[89] = Qh[90][Qh[92]];
        Qh[95] = "^\xcc\xd8\xb9\xc7)p";
        Qh[87][Qh[88]] = Qh[89];
        Qh[87] = A[Qh[82]];
        Qh[92] = "G'M\x80\x19\x1a\xb0\xe1U\xb1";
        Qh[89] = r15;
        Qh[93] = 2480285172866;
        Qh[96] = 29222819149095;
        Qh[90] = r16;
        Qh[91] = Qh[90](Qh[92], Qh[93]);
        Qh[88] = Qh[89][Qh[91]];
        Qh[91] = "Color3";
        Qh[90] = Env[Qh[91]];
        Qh[92] = r15;
        Qh[93] = r16;
        Qh[94] = Qh[93](Qh[95], Qh[96]);
        Qh[91] = Qh[92][Qh[94]];
        Qh[89] = Qh[90][Qh[91]];
        Qh[92] = 255;
        Qh[93] = 180;
        Qh[91] = 180;
        Qh[90] = Qh[89](Qh[91], Qh[92], Qh[93]);
        Qh[93] = 26904260440304;
        Qh[87][Qh[88]] = Qh[90];
        Qh[87] = A[Qh[82]];
        Qh[89] = r15;
        Qh[35] = nil;
        Qh[92] = "\xc7u\xb0\x17\xbd\xd69\x98";
        Qh[90] = r16;
        Qh[96] = "E\x8b)\xb3";
        Qh[91] = Qh[90](Qh[92], Qh[93]);
        Qh[88] = Qh[89][Qh[91]];
        Qh[73] = nil;
        Qh[89] = 12;
        Qh[87][Qh[88]] = Qh[89];
        Qh[87] = A[Qh[82]];
        Qh[89] = r15;
        Qh[93] = 20884771694077;
        Qh[90] = r16;
        Qh[92] = "\x947\xd0\x88";
        Qh[91] = Qh[90](Qh[92], Qh[93]);
        Qh[88] = Qh[89][Qh[91]];
        Qh[92] = "Enum";
        Qh[91] = Env[Qh[92]];
        Qh[93] = r15;
        Qh[94] = r16;
        Qh[95] = Qh[94](Qh[96], Qh[97]);
        Qh[92] = Qh[93][Qh[95]];
        Qh[90] = Qh[91][Qh[92]];
        Qh[95] = "\xd6\x1a\x14\x05\xb3\xd5\x8f+,\xc1\x06\x00";
        Qh[96] = 13631000729803;
        Qh[92] = r15;
        Qh[93] = r16;
        Qh[94] = Qh[93](Qh[95], Qh[96]);
        Qh[91] = Qh[92][Qh[94]];
        Qh[92] = "=,\xb3\xf6\x87\x03\xf48\xf5\x8d3\x94\x9f\x07";
        Qh[93] = 17407944302506;
        Qh[89] = Qh[90][Qh[91]];
        Qh[87][Qh[88]] = Qh[89];
        Qh[97] = 30453216130916;
        Qh[87] = A[Qh[82]];
        Qh[89] = r15;
        Qh[17] = nil;
        Qh[90] = r16;
        Qh[91] = Qh[90](Qh[92], Qh[93]);
        Qh[92] = "Enum";
        Qh[88] = Qh[89][Qh[91]];
        Qh[91] = Env[Qh[92]];
        Qh[93] = r15;
        Qh[94] = r16;
        Qh[96] = "\xa04\x8a\x04\xba\xcaFS\x18\x9d\xe1\xbf\x10\xb8";
        Qh[95] = Qh[94](Qh[96], Qh[97]);
        Qh[92] = Qh[93][Qh[95]];
        Qh[97] = 19843310314520;
        Qh[90] = Qh[91][Qh[92]];
        Qh[95] = "\xec\xe7\xa5m\xc5\xbf";
        Qh[96] = 23602877852398;
        Qh[92] = r15;
        Qh[93] = r16;
        Qh[94] = Qh[93](Qh[95], Qh[96]);
        Qh[91] = Qh[92][Qh[94]];
        Qh[4] = nil;
        Qh[96] = "4\x8ci\x02<=V\x1c^\xe9\xfb\xbd\xc3\xfe";
        Qh[89] = Qh[90][Qh[91]];
        Qh[92] = "\xd7S\x18.\xac\xd5\x1f&\xb3\x17\xa9\x03F1";
        Qh[93] = 29619627210208;
        Qh[87][Qh[88]] = Qh[89];
        Qh[87] = A[Qh[82]];
        Qh[89] = r15;
        Qh[90] = r16;
        Qh[91] = Qh[90](Qh[92], Qh[93]);
        Qh[92] = "Enum";
        Qh[88] = Qh[89][Qh[91]];
        Qh[91] = Env[Qh[92]];
        Qh[93] = r15;
        Qh[94] = r16;
        Qh[102] = 24895338442056;
        Qh[95] = Qh[94](Qh[96], Qh[97]);
        Qh[96] = 10163512070780;
        Qh[92] = Qh[93][Qh[95]];
        Qh[90] = Qh[91][Qh[92]];
        Qh[95] = "\xd6\x00o\xc1 s";
        Qh[92] = r15;
        Qh[93] = r16;
        Qh[94] = Qh[93](Qh[95], Qh[96]);
        Qh[23] = nil;
        Qh[91] = Qh[92][Qh[94]];
        Qh[89] = Qh[90][Qh[91]];
        Qh[87][Qh[88]] = Qh[89];
        Qh[95] = "I\xbaPC\x0eA\xb1\xd7k\x1b\xcc\xfc\xb4";
        Qh[87] = A[Qh[82]];
        Qh[92] = "E\xed\xd4tq\xd8";
        Qh[89] = r15;
        Qh[96] = 17703000776755;
        Qh[41] = nil;
        Qh[90] = r16;
        Qh[93] = 17559837433840;
        Qh[91] = Qh[90](Qh[92], Qh[93]);
        Qh[88] = Qh[89][Qh[91]];
        Qh[89] = A[Qh[79]];
        Qh[87][Qh[88]] = Qh[89];
        Qh[89] = "tick";
        Qh[88] = 189;
        Qh[87] = 0;
        A[Qh[88]] = Qh[87];
        Qh[87] = Env[Qh[89]];
        Qh[89] = Qh[87]();
        Qh[87] = 190;
        A[Qh[87]] = Qh[89];
        Qh[90] = r25;
        Qh[92] = r15;
        Qh[93] = r16;
        Qh[94] = Qh[93](Qh[95], Qh[96]);
        Qh[91] = Qh[92][Qh[94]];
        Qh[89] = Qh[90][Qh[91]];
        Qh[96] = 12500762662589;
        Qh[91] = function(...)
            A[Qh[88]] = A[Qh[88]] + 1;
            v1 = tick();
            j = v1 - A[Qh[87]];
            if j >= 1 then
                j = math.floor(A[Qh[88]] / (v1 - A[Qh[87]]));
                A[Qh[82]].Text = j;
                if j >= 60 then
                    A[Qh[82]].TextColor3 = Color3.fromRGB(180, 255, 180);
                else
                    if math.floor(A[Qh[88]] / (v1 - A[Qh[87]])) >= 30 then
                        A[Qh[82]].TextColor3 = Color3.fromRGB(255, 255, 150);
                    else
                        A[Qh[82]].TextColor3 = Color3.fromRGB(255, 150, 150);
                    end;
                    A[Qh[88]] = 0;
                    A[Qh[87]] = tick();
                end;
            end;
            return; 
        end;
        Qh[90] = "Connect";
        Qh[90] = Qh[89][Qh[90]];
        Qh[1] = nil;
        Qh[90] = Qh[90](Qh[89], Qh[91]);
        Qh[76] = nil;
        Qh[91] = "Instance";
        Qh[95] = "'z\xc6";
        Qh[90] = Env[Qh[91]];
        Qh[92] = r15;
        Qh[93] = r16;
        Qh[94] = Qh[93](Qh[95], Qh[96]);
        Qh[24] = nil;
        Qh[91] = Qh[92][Qh[94]];
        Qh[47] = nil;
        Qh[96] = 8691073159119;
        Qh[89] = Qh[90][Qh[91]];
        Qh[92] = r15;
        Qh[93] = r16;
        Qh[95] = "\xc8\xec\xa6\xee\xa6";
        Qh[94] = Qh[93](Qh[95], Qh[96]);
        Qh[95] = 23199399324211;
        Qh[91] = Qh[92][Qh[94]];
        Qh[90] = Qh[89](Qh[91]);
        Qh[94] = ";\x84P\x1a";
        Qh[54] = nil;
        Qh[91] = r15;
        Qh[92] = r16;
        Qh[97] = "\xe8\xd8\xba";
        Qh[33] = nil;
        Qh[93] = Qh[92](Qh[94], Qh[95]);
        Qh[89] = Qh[91][Qh[93]];
        Qh[93] = "UDim2";
        Qh[92] = Env[Qh[93]];
        Qh[48] = nil;
        Qh[94] = r15;
        Qh[95] = r16;
        Qh[96] = Qh[95](Qh[97], Qh[98]);
        Qh[93] = Qh[94][Qh[96]];
        Qh[96] = 16;
        Qh[95] = 0;
        Qh[98] = 12097332237825;
        Qh[7] = nil;
        Qh[97] = "\x8f\xb4V";
        Qh[94] = 1;
        Qh[91] = Qh[92][Qh[93]];
        Qh[93] = 0;
        Qh[92] = Qh[91](Qh[93], Qh[94], Qh[95], Qh[96]);
        Qh[95] = 6989992070326;
        Qh[90][Qh[89]] = Qh[92];
        Qh[91] = r15;
        Qh[92] = r16;
        Qh[94] = "\xc5\xdf\xa7\xaaU+\x12\xde";
        Qh[66] = nil;
        Qh[93] = Qh[92](Qh[94], Qh[95]);
        Qh[89] = Qh[91][Qh[93]];
        Qh[93] = "UDim2";
        Qh[59] = nil;
        Qh[92] = Env[Qh[93]];
        Qh[94] = r15;
        Qh[95] = r16;
        Qh[19] = nil;
        Qh[96] = Qh[95](Qh[97], Qh[98]);
        Qh[93] = Qh[94][Qh[96]];
        Qh[91] = Qh[92][Qh[93]];
        Qh[67] = nil;
        Qh[94] = 103;
        Qh[95] = 0.5;
        Qh[98] = 21923343820768;
        Qh[93] = 0;
        Qh[96] = -8;
        Qh[39] = nil;
        Qh[92] = Qh[91](Qh[93], Qh[94], Qh[95], Qh[96]);
        Qh[90][Qh[89]] = Qh[92];
        Qh[94] = "\x06l\xea\xeau9\x83\x8b\x01\xbb\x1e\x7f\x1a\x1djY";
        Qh[91] = r15;
        Qh[97] = "\xfb\xcc\xc0\xda\x8c\x8f\x82";
        Qh[95] = 24497029655695;
        Qh[92] = r16;
        Qh[93] = Qh[92](Qh[94], Qh[95]);
        Qh[89] = Qh[91][Qh[93]];
        Qh[93] = "Color3";
        Qh[92] = Env[Qh[93]];
        Qh[94] = r15;
        Qh[95] = r16;
        Qh[96] = Qh[95](Qh[97], Qh[98]);
        Qh[93] = Qh[94][Qh[96]];
        Qh[25] = nil;
        Qh[91] = Qh[92][Qh[93]];
        Qh[95] = 70;
        Qh[97] = 15961790864648;
        Qh[94] = 60;
        Qh[98] = "\xf5\xf3\x0f";
        Qh[93] = 60;
        Qh[92] = Qh[91](Qh[93], Qh[94], Qh[95]);
        Qh[90][Qh[89]] = Qh[92];
        Qh[91] = r15;
        Qh[94] = "\xb4h\x15\x0f\xa1\r/\xac\x87\xcbz\x1b\xd2O\xc6";
        Qh[92] = r16;
        Qh[95] = 9983187554856;
        Qh[93] = Qh[92](Qh[94], Qh[95]);
        Qh[94] = "\xbc\x8b.\xfeR\x83";
        Qh[89] = Qh[91][Qh[93]];
        Qh[91] = 0;
        Qh[90][Qh[89]] = Qh[91];
        Qh[91] = r15;
        Qh[92] = r16;
        Qh[95] = 26977314844946;
        Qh[93] = Qh[92](Qh[94], Qh[95]);
        Qh[96] = ";\x81'";
        Qh[92] = "Instance";
        Qh[89] = Qh[91][Qh[93]];
        Qh[91] = A[Qh[79]];
        Qh[90][Qh[89]] = Qh[91];
        Qh[91] = Env[Qh[92]];
        Qh[93] = r15;
        Qh[94] = r16;
        Qh[95] = Qh[94](Qh[96], Qh[97]);
        Qh[92] = Qh[93][Qh[95]];
        Qh[97] = 1703075906329;
        Qh[96] = "6\xb0C\"u\xf0\xdct\x94";
        Qh[89] = Qh[91][Qh[92]];
        Qh[93] = r15;
        Qh[94] = r16;
        Qh[95] = Qh[94](Qh[96], Qh[97]);
        Qh[38] = nil;
        Qh[92] = Qh[93][Qh[95]];
        Qh[95] = "Xlb\xbc";
        Qh[91] = Qh[89](Qh[92]);
        Qh[96] = 12677714433807;
        Qh[92] = r15;
        Qh[93] = r16;
        Qh[94] = Qh[93](Qh[95], Qh[96]);
        Qh[89] = Qh[92][Qh[94]];
        Qh[94] = "UDim2";
        Qh[93] = Env[Qh[94]];
        Qh[95] = r15;
        Qh[96] = r16;
        Qh[97] = Qh[96](Qh[98], Qh[99]);
        Qh[94] = Qh[95][Qh[97]];
        Qh[92] = Qh[93][Qh[94]];
        Qh[96] = 1;
        Qh[94] = 0;
        Qh[95] = 40;
        Qh[97] = 0;
        Qh[93] = Qh[92](Qh[94], Qh[95], Qh[96], Qh[97]);
        Qh[96] = 15334076636132;
        Qh[91][Qh[89]] = Qh[93];
        Qh[6] = nil;
        Qh[92] = r15;
        Qh[93] = r16;
        Qh[95] = "2i\x8c\xef*\xae\xd3\xb9";
        Qh[94] = Qh[93](Qh[95], Qh[96]);
        Qh[89] = Qh[92][Qh[94]];
        Qh[18] = nil;
        Qh[99] = 30085658736313;
        Qh[94] = "UDim2";
        Qh[93] = Env[Qh[94]];
        Qh[98] = "\xd3\x10N";
        Qh[95] = r15;
        Qh[96] = r16;
        Qh[97] = Qh[96](Qh[98], Qh[99]);
        Qh[96] = 0;
        Qh[94] = Qh[95][Qh[97]];
        Qh[95] = 108;
        Qh[92] = Qh[93][Qh[94]];
        Qh[94] = 0;
        Qh[97] = 0;
        Qh[93] = Qh[92](Qh[94], Qh[95], Qh[96], Qh[97]);
        Qh[96] = 33732761369948;
        Qh[91][Qh[89]] = Qh[93];
        Qh[92] = r15;
        Qh[95] = "kd\x07\xb3\x1b)gz\x9b\xb1\xa7\x00\x1d\xfe\x1c\x00|\xa9\xcd{\xfd\x92";
        Qh[93] = r16;
        Qh[94] = Qh[93](Qh[95], Qh[96]);
        Qh[99] = 13916094470480;
        Qh[96] = 3752582383315;
        Qh[95] = "^\xda!Y";
        Qh[89] = Qh[92][Qh[94]];
        Qh[92] = 1;
        Qh[77] = nil;
        Qh[91][Qh[89]] = Qh[92];
        Qh[92] = r15;
        Qh[93] = r16;
        Qh[97] = 24520913841306;
        Qh[94] = Qh[93](Qh[95], Qh[96]);
        Qh[89] = Qh[92][Qh[94]];
        Qh[93] = r15;
        Qh[96] = "\x06S\x14I";
        Qh[94] = r16;
        Qh[95] = Qh[94](Qh[96], Qh[97]);
        Qh[92] = Qh[93][Qh[95]];
        Qh[91][Qh[89]] = Qh[92];
        Qh[92] = r15;
        Qh[98] = "\x93u\x8e\xc7\xfaK\x87";
        Qh[93] = r16;
        Qh[95] = "\x0e\xe5b*\xb3o\xce\x15\x82\xe4";
        Qh[96] = 18391699579252;
        Qh[94] = Qh[93](Qh[95], Qh[96]);
        Qh[70] = nil;
        Qh[89] = Qh[92][Qh[94]];
        Qh[94] = "Color3";
        Qh[93] = Env[Qh[94]];
        Qh[95] = r15;
        Qh[96] = r16;
        Qh[97] = Qh[96](Qh[98], Qh[99]);
        Qh[96] = 150;
        Qh[94] = Qh[95][Qh[97]];
        Qh[82] = nil;
        Qh[92] = Qh[93][Qh[94]];
        Qh[95] = 255;
        Qh[94] = 150;
        Qh[93] = Qh[92](Qh[94], Qh[95], Qh[96]);
        Qh[91][Qh[89]] = Qh[93];
        Qh[96] = 6896379169931;
        Qh[95] = "\xa6\tz;`X\xe1\xf7";
        Qh[92] = r15;
        Qh[93] = r16;
        Qh[94] = Qh[93](Qh[95], Qh[96]);
        Qh[96] = 910328267175;
        Qh[89] = Qh[92][Qh[94]];
        Qh[99] = "\x9c\x19\xd5\x97";
        Qh[92] = 11;
        Qh[91][Qh[89]] = Qh[92];
        Qh[92] = r15;
        Qh[93] = r16;
        Qh[95] = "o\x1f\xcfm";
        Qh[94] = Qh[93](Qh[95], Qh[96]);
        Qh[89] = Qh[92][Qh[94]];
        Qh[95] = "Enum";
        Qh[94] = Env[Qh[95]];
        Qh[96] = r15;
        Qh[75] = nil;
        Qh[97] = r16;
        Qh[98] = Qh[97](Qh[99], Qh[100]);
        Qh[95] = Qh[96][Qh[98]];
        Qh[98] = "\x14\x89\x97\xb5\xc3\x82\xa8\x8f\x07`@{";
        Qh[93] = Qh[94][Qh[95]];
        Qh[95] = r15;
        Qh[96] = r16;
        Qh[99] = 30047927580328;
        Qh[97] = Qh[96](Qh[98], Qh[99]);
        Qh[94] = Qh[95][Qh[97]];
        Qh[92] = Qh[93][Qh[94]];
        Qh[100] = 5814414658195;
        Qh[91][Qh[89]] = Qh[92];
        Qh[96] = 6583792995321;
        Qh[99] = "+\xb5\xe2(\xda\x89\xaaH |$\xfcZ\xec";
        Qh[92] = r15;
        Qh[93] = r16;
        Qh[60] = nil;
        Qh[95] = "$\\Zec\xc2\xf9\xb3\x84\x12\xa1&\x9fy";
        Qh[94] = Qh[93](Qh[95], Qh[96]);
        Qh[95] = "Enum";
        Qh[89] = Qh[92][Qh[94]];
        Qh[94] = Env[Qh[95]];
        Qh[28] = nil;
        Qh[96] = r15;
        Qh[97] = r16;
        Qh[98] = Qh[97](Qh[99], Qh[100]);
        Qh[95] = Qh[96][Qh[98]];
        Qh[99] = 777323250025;
        Qh[93] = Qh[94][Qh[95]];
        Qh[98] = "*F)\xb8\xa3(";
        Qh[95] = r15;
        Qh[96] = r16;
        Qh[97] = Qh[96](Qh[98], Qh[99]);
        Qh[94] = Qh[95][Qh[97]];
        Qh[92] = Qh[93][Qh[94]];
        Qh[96] = 26115316592512;
        Qh[95] = "T\xe4\xf6\xf0\xe9\x90;.9\x04,\x1b\xf8l";
        Qh[91][Qh[89]] = Qh[92];
        Qh[55] = nil;
        Qh[92] = r15;
        Qh[93] = r16;
        Qh[94] = Qh[93](Qh[95], Qh[96]);
        Qh[89] = Qh[92][Qh[94]];
        Qh[101] = 21369698215647;
        Qh[95] = "Enum";
        Qh[94] = Env[Qh[95]];
        Qh[57] = nil;
        Qh[99] = "b\xf9\x0e\xa7h\xf6U\xe7h\xd03W\x80\xee";
        Qh[96] = r15;
        Qh[97] = r16;
        Qh[100] = 5688632986200;
        Qh[98] = Qh[97](Qh[99], Qh[100]);
        Qh[95] = Qh[96][Qh[98]];
        Qh[93] = Qh[94][Qh[95]];
        Qh[99] = 23626458180345;
        Qh[98] = "\xd3$.\x03\xc3\x87";
        Qh[95] = r15;
        Qh[96] = r16;
        Qh[97] = Qh[96](Qh[98], Qh[99]);
        Qh[96] = 3431707149886;
        Qh[94] = Qh[95][Qh[97]];
        Qh[92] = Qh[93][Qh[94]];
        Qh[91][Qh[89]] = Qh[92];
        Qh[92] = r15;
        Qh[93] = r16;
        Qh[95] = "-\x16q\x01\x04\xe3";
        Qh[94] = Qh[93](Qh[95], Qh[96]);
        Qh[89] = Qh[92][Qh[94]];
        Qh[94] = "Instance";
        Qh[92] = A[Qh[79]];
        Qh[91][Qh[89]] = Qh[92];
        Qh[98] = "G\xb2\xde";
        Qh[92] = 191;
        Qh[89] = true;
        Qh[99] = 14379706145320;
        A[Qh[92]] = Qh[89];
        Qh[93] = Env[Qh[94]];
        Qh[95] = r15;
        Qh[96] = r16;
        Qh[97] = Qh[96](Qh[98], Qh[99]);
        Qh[98] = "\xd9\x08P-\xa0v\xa7\xdeO\xdc";
        Qh[94] = Qh[95][Qh[97]];
        Qh[89] = Qh[93][Qh[94]];
        Qh[95] = r15;
        Qh[99] = 11641485415724;
        Qh[96] = r16;
        Qh[97] = Qh[96](Qh[98], Qh[99]);
        Qh[94] = Qh[95][Qh[97]];
        Qh[97] = "\xf2\xe9kK";
        Qh[100] = "\xe1\xa0.";
        Qh[93] = Qh[89](Qh[94]);
        Qh[98] = 31112023701655;
        Qh[94] = r15;
        Qh[95] = r16;
        Qh[96] = Qh[95](Qh[97], Qh[98]);
        Qh[89] = Qh[94][Qh[96]];
        Qh[96] = "UDim2";
        Qh[95] = Env[Qh[96]];
        Qh[97] = r15;
        Qh[98] = r16;
        Qh[99] = Qh[98](Qh[100], Qh[101]);
        Qh[96] = Qh[97][Qh[99]];
        Qh[97] = 0;
        Qh[94] = Qh[95][Qh[96]];
        Qh[96] = 1;
        Qh[98] = 1;
        Qh[99] = 0;
        Qh[95] = Qh[94](Qh[96], Qh[97], Qh[98], Qh[99]);
        Qh[15] = nil;
        Qh[98] = 23738817653550;
        Qh[93][Qh[89]] = Qh[95];
        Qh[97] = "jw\xff\xfe\xbe\n%7\x019\xf4\xcd\xfb\x02\xfb\xfd\x9b\x80P'Uc";
        Qh[94] = r15;
        Qh[95] = r16;
        Qh[96] = Qh[95](Qh[97], Qh[98]);
        Qh[99] = 8108669947583;
        Qh[89] = Qh[94][Qh[96]];
        Qh[94] = 1;
        Qh[93][Qh[89]] = Qh[94];
        Qh[98] = 20424681268518;
        Qh[94] = r15;
        Qh[95] = r16;
        Qh[97] = "\xa5S\x11\x8c";
        Qh[96] = Qh[95](Qh[97], Qh[98]);
        Qh[98] = "";
        Qh[89] = Qh[94][Qh[96]];
        Qh[95] = r15;
        Qh[96] = r16;
        Qh[97] = Qh[96](Qh[98], Qh[99]);
        Qh[94] = Qh[95][Qh[97]];
        Qh[93][Qh[89]] = Qh[94];
        Qh[94] = r15;
        Qh[99] = 24070460812232;
        Qh[95] = r16;
        Qh[97] = "Nq&;\xd1\xe1";
        Qh[98] = 33722005208407;
        Qh[96] = Qh[95](Qh[97], Qh[98]);
        Qh[89] = Qh[94][Qh[96]];
        Qh[98] = 12217624008249;
        Qh[94] = 10;
        Qh[93][Qh[89]] = Qh[94];
        Qh[94] = r15;
        Qh[95] = r16;
        Qh[97] = "\xfdnw\x01\x97\xb0";
        Qh[96] = Qh[95](Qh[97], Qh[98]);
        Qh[98] = "*#l\x90\xbcW\x02\x14+\x86]$\xa4TO\xeeD";
        Qh[89] = Qh[94][Qh[96]];
        Qh[94] = A[Qh[79]];
        Qh[93][Qh[89]] = Qh[94];
        Qh[95] = r15;
        Qh[96] = r16;
        Qh[88] = nil;
        Qh[97] = Qh[96](Qh[98], Qh[99]);
        Qh[94] = Qh[95][Qh[97]];
        Qh[89] = Qh[93][Qh[94]];
        Qh[95] = function(...)
            A[Qh[92]] = not A[Qh[92]];
            r37.Visible = A[Qh[92]];
            return; 
        end;
        Qh[94] = "Connect";
        Qh[94] = Qh[89][Qh[94]];
        Qh[91] = nil;
        Qh[94] = Qh[94](Qh[89], Qh[95]);
        Qh[89] = nil;
        Qh[94] = 192;
        Qh[81] = nil;
        A[Qh[94]] = Qh[89];
        Qh[101] = "\x87\x8b\xf1\xa0\xaa\xd0&\xa4\xde\x1f";
        Qh[68] = nil;
        Qh[95] = 193;
        Qh[89] = nil;
        A[Qh[95]] = Qh[89];
        Qh[96] = A[Qh[79]];
        Qh[98] = r15;
        Qh[99] = r16;
        Qh[100] = Qh[99](Qh[101], Qh[102]);
        Qh[101] = "\xd8\xc0,\x85\xf9\x8aL\xeb?z\x9b\xcb";
        Qh[97] = Qh[98][Qh[100]];
        Qh[89] = Qh[96][Qh[97]];
        Qh[97] = function(arg1_124, ...)
            v1 = arg1_124;
            if v1.UserInputType == Enum.UserInputType.MouseButton1 then
                A[Qh[94]] = v1.Position;
                A[Qh[95]] = A[Qh[79]].Position;
            end;
            return; 
        end;
        Qh[96] = "Connect";
        Qh[96] = Qh[89][Qh[96]];
        Qh[96] = Qh[96](Qh[89], Qh[97]);
        Qh[96] = r27;
        Qh[32] = nil;
        Qh[98] = r15;
        Qh[99] = r16;
        Qh[102] = 9133166809244;
        Qh[100] = Qh[99](Qh[101], Qh[102]);
        Qh[97] = Qh[98][Qh[100]];
        Qh[89] = Qh[96][Qh[97]];
        Qh[97] = function(arg1_125, ...)
            v1 = arg1_125;
            if v1.UserInputType == Enum.UserInputType.MouseMovement and A[Qh[94]] then
                j = v1.Position - A[Qh[94]];
                A[Qh[79]].Position = UDim2.new(A[Qh[95]].v2.Scale, A[Qh[95]].v2.Offset + j.v2, A[Qh[95]].v3.Scale, A[Qh[95]].v3.Offset + j.v3);
            end;
            return; 
        end;
        Qh[101] = "\x9e#\x97\x83\x8aY\xc6M\xa8\xa7";
        Qh[96] = "Connect";
        Qh[102] = 10724840231810;
        Qh[96] = Qh[89][Qh[96]];
        Qh[96] = Qh[96](Qh[89], Qh[97]);
        Qh[96] = r27;
        Qh[98] = r15;
        Qh[99] = r16;
        Qh[100] = Qh[99](Qh[101], Qh[102]);
        Qh[97] = Qh[98][Qh[100]];
        Qh[89] = Qh[96][Qh[97]];
        Qh[95] = nil;
        Qh[97] = function(arg1_126, ...)
            if arg1_126.UserInputType == Enum.UserInputType.MouseButton1 then
                A[Qh[94]] = nil;
            end;
            return; 
        end;
        Qh[96] = "Connect";
        Qh[96] = Qh[89][Qh[96]];
        Qh[87] = nil;
        Qh[96] = Qh[96](Qh[89], Qh[97]);
        Qh[101] = "\"\x17o\r\xfbp\xd1z?\x1c";
        Qh[96] = r27;
        Qh[85] = nil;
        Qh[98] = r15;
        Qh[102] = 34030446984678;
        Qh[99] = r16;
        Qh[100] = Qh[99](Qh[101], Qh[102]);
        Qh[97] = Qh[98][Qh[100]];
        Qh[89] = Qh[96][Qh[97]];
        Qh[96] = "Connect";
        Qh[34] = nil;
        Qh[102] = 35069604954058;
        Qh[97] = function(arg1_127, arg2_127, ...)
            if arg2_127 then
                return;
            end;
            if arg1_127.KeyCode == Enum.KeyCode.T then
                A[Qh[92]] = not A[Qh[92]];
                r37.Visible = A[Qh[92]];
            end;
            return; 
        end;
        Qh[96] = Qh[89][Qh[96]];
        Qh[96] = Qh[96](Qh[89], Qh[97]);
        Qh[92] = nil;
        Qh[22] = nil;
        Qh[96] = "print";
        Qh[89] = Env[Qh[96]];
        Qh[93] = nil;
        Qh[98] = r15;
        Qh[90] = nil;
        Qh[101] = "S\"\x18\xee\xa9\xdb{\xf7\xa3\xa9.\x9b\xf07\txwQ\xdd\x87\x83\x08s{'n\x83\x9c\xf6e\xe4\x0e\x0f<\x15t\x819O\xf7\x87~\r\n\xd0\x9a";
        Qh[99] = r16;
        Qh[100] = Qh[99](Qh[101], Qh[102]);
        Qh[94] = nil;
        Qh[97] = Qh[98][Qh[100]];
        Qh[96] = Qh[89](Qh[97]);
        Qh[79] = nil;
        Qh[96] = "print";
        Qh[101] = "\xec4m/C\x89\xefN~6\x1e/B\x97\xf9\xc6t\xd4\x88\xd0>].i\x175G[\xd3M\x1e\xedz\xc0M\xf1\xfc\x94\x8e\xfd\xc4S`\x1e`\xbf \xdd\xd8\xc8\x8fD\xd4?\xde<,U\xc4\xadj\x8c0\x9c\xb2\xed\xd1<C\xea\xed}\x04\x08\xac\xd4\x89yD\xf0\xbc\xce\xb9:\xdb\x93+(K\xe8\xd6\x8a\xef\x1d";
        Qh[89] = Env[Qh[96]];
        Qh[102] = 14661569551019;
        Qh[98] = r15;
        Qh[99] = r16;
        Qh[100] = Qh[99](Qh[101], Qh[102]);
        Qh[97] = Qh[98][Qh[100]];
        Qh[96] = Qh[89](Qh[97]);
        return;
    end;
end;
return (function(...)
    while true do
        l1 = l2;
        l2 = l1;
        r3(); 
    end;
    return; 
end)();