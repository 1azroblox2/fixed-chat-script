-- 1AZROBLOXCHAT FIXED VERSION

local Players = game:GetService("Players")
local player = Players.LocalPlayer

local chatUI = nil

local CHAT_COLORS = {
    Background = Color3.fromRGB(25,5,8),
    OwnerName = Color3.fromRGB(255,100,150),
    NormalName = Color3.fromRGB(200,120,150),
    Message = Color3.fromRGB(240,200,210),
    Border = Color3.fromRGB(80,20,40)
}

local OWNER_USERIDS = {
    5224146556
}

local function isOwner(id)
    for _,v in pairs(OWNER_USERIDS) do
        if v == id then
            return true
        end
    end
    return false
end

function createUI()

    local gui = Instance.new("ScreenGui")
    gui.Name = "1AZROBLOXCHAT_UI"
    gui.ResetOnSpawn = false

    local main = Instance.new("Frame")
    main.Size = UDim2.new(0,450,0,350)
    main.Position = UDim2.new(0,20,1,-370)
    main.BackgroundColor3 = CHAT_COLORS.Background
    main.BorderColor3 = CHAT_COLORS.Border
    main.Parent = gui

    local chatFrame = Instance.new("ScrollingFrame")
    chatFrame.Size = UDim2.new(1,-20,1,-120)
    chatFrame.Position = UDim2.new(0,10,0,10)
    chatFrame.BackgroundTransparency = 1
    chatFrame.Parent = main

    local layout = Instance.new("UIListLayout")
    layout.Parent = chatFrame

    local textBox = Instance.new("TextBox")
    textBox.Size = UDim2.new(1,-20,0,35)
    textBox.Position = UDim2.new(0,10,1,-40)
    textBox.PlaceholderText = "Mesaj yaz..."
    textBox.TextColor3 = CHAT_COLORS.Message
    textBox.BackgroundColor3 = CHAT_COLORS.Border
    textBox.ClearTextOnFocus = false
    textBox.Parent = main

    gui.Parent = player:WaitForChild("PlayerGui")

    chatUI = {
        Gui = gui,
        ChatFrame = chatFrame,
        TextBox = textBox
    }

end


function addMessage(name,msg,isowner)

    if not chatUI then return end

    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(1,0,0,25)
    frame.BackgroundTransparency = 1

    local nameLabel = Instance.new("TextLabel")
    nameLabel.Size = UDim2.new(0,120,1,0)
    nameLabel.BackgroundTransparency = 1
    nameLabel.Text = (isowner and "[OWNER] " or "")..name
    nameLabel.TextColor3 = isowner and CHAT_COLORS.OwnerName or CHAT_COLORS.NormalName
    nameLabel.TextXAlignment = Enum.TextXAlignment.Left
    nameLabel.Parent = frame

    local msgLabel = Instance.new("TextLabel")
    msgLabel.Size = UDim2.new(1,-120,1,0)
    msgLabel.Position = UDim2.new(0,120,0,0)
    msgLabel.BackgroundTransparency = 1
    msgLabel.Text = msg
    msgLabel.TextColor3 = CHAT_COLORS.Message
    msgLabel.TextXAlignment = Enum.TextXAlignment.Left
    msgLabel.Parent = frame

    frame.Parent = chatUI.ChatFrame
end


function startChat()

    createUI()

    addMessage("1AZROBLOXCHAT","Sistem başlatıldı",true)

    chatUI.TextBox.FocusLost:Connect(function(enter)

        if enter then

            local msg = chatUI.TextBox.Text

            if msg ~= "" then
                addMessage(player.Name,msg,isOwner(player.UserId))
                chatUI.TextBox.Text = ""
            end

        end

    end)

end


if player then

    player.CharacterAdded:Connect(function()
        task.wait(1)
        startChat()
    end)

    if player.Character then
        startChat()
    end

end


getgenv().AZChat = {}

function AZChat.ToggleChat()

    local gui = player.PlayerGui:FindFirstChild("1AZROBLOXCHAT_UI")

    if gui then
        gui.Enabled = not gui.Enabled
    end

end
