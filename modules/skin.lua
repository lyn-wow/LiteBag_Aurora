	if not IsAddOnLoaded'LiteBag' and not IsAddOnLoaded'Aurora' then return end;
		
	-- litebag aurora
	local F, C = unpack(Aurora)
	local BORDERTEXTURE = [[Interface\AddOns\LiteBag_Aurora\assets\border.tga]]
	_G.TEXTURE_ITEM_QUEST_BANG   = [[Interface\AddOns\LiteBag_Aurora\assets\borderquest2.tga]]
	_G.TEXTURE_ITEM_QUEST_BORDER = [[Interface\AddOns\LiteBag_Aurora\assets\borderquest1.tga]]

	local skinLiteBag = function(name)
	
		-- hide textures
		local textures = {
			'TokenFrameBorderLeft',
			'TokenFrameBorderRight',
			'TokenFrameBorderMiddle',
			'MoneyFrameBorderLeft',
			'MoneyFrameBorderRight',
			'MoneyFrameBorderMiddle',
			'Bg',
			'TitleBg',
			'Portrait',
			'PortraitFrame',
			'TopRightCorner',
			'TopLeftCorner',
			'TopBorder',
			'TopTileStreaks',
			'BotLeftCorner',
			'BotRightCorner',
			'BottomBorder',
			'LeftBorder',
			'RightBorder',
			'BtnCornerLeft',
			'BtnCornerRight',
			'ButtonBottomBorder',
			'Inset',
			'InsetBg',
		}
		
		for i, texture in ipairs(textures) do
			if _G['LiteBag'..name..texture] then
				_G['LiteBag'..name..texture]:SetAlpha(0)
			end
		end
		
		-- frame
		F.CreateBD(_G['LiteBag'..name])
		
		-- close
		F.ReskinClose(_G['LiteBag'..name..'CloseButton'], 'TOPRIGHT', _G['LiteBag'..name], 'TOPRIGHT', -6, -6)
		
		-- token border
		F.CreateBD(_G['LiteBag'..name..'TokenFrameBorder'])
		_G['LiteBag'..name..'TokenFrameBorder']:ClearAllPoints()
		_G['LiteBag'..name..'TokenFrameBorder']:SetPoint('BOTTOMLEFT', 13, 7)
		
		-- token
		_G['LiteBag'..name..'Token1']:ClearAllPoints()
		_G['LiteBag'..name..'Token1']:SetPoint('BOTTOMLEFT', 18, 10)
		
		-- money border
		F.CreateBD(_G['LiteBag'..name..'MoneyFrameBorder'])
		_G['LiteBag'..name..'MoneyFrameBorder']:ClearAllPoints()
		_G['LiteBag'..name..'MoneyFrameBorder']:SetPoint('BOTTOMRIGHT', -13, 7)
		
		-- money
		_G['LiteBag'..name..'MoneyFrame']:ClearAllPoints()
		_G['LiteBag'..name..'MoneyFrame']:SetPoint('BOTTOMRIGHT', -18, 10)

		-- tabs
		if name == 'Bank' then
			F.ReskinTab(_G['LiteBag'..name..'Tab1'])
			F.ReskinTab(_G['LiteBag'..name..'Tab2'])
		end
	
		-- move bag buttons
		_G['LiteBag'..name..'BagButton1']:ClearAllPoints()
		_G['LiteBag'..name..'BagButton1']:SetPoint('TOPLEFT', 15, -31)
		
		-- skin bag buttons
		for index = 1, 8 do
			local button = _G['LiteBag'..name..'BagButton'..index]
			local icon 	 = _G['LiteBag'..name..'BagButton'..index..'IconTexture']
			if button then
				F.ReskinIcon(icon)
				F.Reskin(button)
			end
		end
	
	end
	
	hooksecurefunc('LiteBagFrame_AttachSearchBox', function(self) 
		self.searchBox:SetPoint('TOPRIGHT', self, 'TOPRIGHT', -46, -35)
		self.sortButton:SetPoint('TOPRIGHT', self, 'TOPRIGHT', -15, -32)	
	end)
		
	local LiteBagItemHook = function (button)
		local slot = button:GetID()
		local bag  = button:GetParent():GetID()
		local name = button:GetName()
		
		-- background
		local background = _G[name..'BackgroundTexture']
		background:SetPoint('TOPLEFT', -1, 1)
		background:SetPoint('BOTTOMRIGHT', 1, -1)
		background:SetColorTexture(0, 0, 0, .4)

		-- icon
		local icon = _G[name..'IconTexture']
		icon:SetTexCoord(.08, .92, .08, .92)
		
		-- border
		local border = _G[name].IconBorder
		border:SetTexture(BORDERTEXTURE)
		border:SetPoint('TOPLEFT', -1, 1)
		border:SetPoint('BOTTOMRIGHT', 1, -1)			
		
		-- normal texture
		local normal = button:GetNormalTexture()
		normal:SetPoint('TOPLEFT', -1, 1)
		normal:SetPoint('BOTTOMRIGHT', 1, -1)
		normal:SetVertexColor(0, 0, 0, 1)
		button:SetNormalTexture(BORDERTEXTURE)
					
		-- pushed texture
		local pushed = button:GetPushedTexture()
		pushed:SetPoint('TOPLEFT', -1, 1)
		pushed:SetPoint('BOTTOMRIGHT', 1, -1)
		pushed:SetVertexColor(1, 1, 0, 1)
		button:SetPushedTexture(BORDERTEXTURE)
		
		-- quest
		local quest = _G[name..'IconQuestTexture']
		quest:SetPoint('TOPLEFT', -1, 1)
		quest:SetPoint('BOTTOMRIGHT', 1, -1)

	end
		
	hooksecurefunc('LiteBagItemButton_Update', LiteBagItemHook)
	hooksecurefunc('LiteBagItemButton_UpdateQuality', LiteBagItemHook)
	
	skinLiteBag('Inventory')
	skinLiteBag('Bank')
