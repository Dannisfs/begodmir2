<GameFile>
  <PropertyGroup Name="Loading" Type="Node" ID="a432cf70-98c8-40e4-ac45-9785205fe699" Version="3.10.0.0" />
  <Content ctype="GameProjectContent">
    <Content>
      <Animation Duration="45" Speed="1.0000">
        <Timeline ActionTag="1873350510" Property="FileData">
          <TextureFrame FrameIndex="0" Tween="False">
            <TextureFile Type="MarkedSubImage" Path="LoadEffects/001.png" Plist="LoginAtlas.plist" />
          </TextureFrame>
          <TextureFrame FrameIndex="5" Tween="False">
            <TextureFile Type="MarkedSubImage" Path="LoadEffects/002.png" Plist="LoginAtlas.plist" />
          </TextureFrame>
          <TextureFrame FrameIndex="10" Tween="False">
            <TextureFile Type="MarkedSubImage" Path="LoadEffects/003.png" Plist="LoginAtlas.plist" />
          </TextureFrame>
          <TextureFrame FrameIndex="15" Tween="False">
            <TextureFile Type="MarkedSubImage" Path="LoadEffects/004.png" Plist="LoginAtlas.plist" />
          </TextureFrame>
          <TextureFrame FrameIndex="20" Tween="False">
            <TextureFile Type="MarkedSubImage" Path="LoadEffects/005.png" Plist="LoginAtlas.plist" />
          </TextureFrame>
          <TextureFrame FrameIndex="25" Tween="False">
            <TextureFile Type="MarkedSubImage" Path="LoadEffects/006.png" Plist="LoginAtlas.plist" />
          </TextureFrame>
          <TextureFrame FrameIndex="30" Tween="False">
            <TextureFile Type="MarkedSubImage" Path="LoadEffects/007.png" Plist="LoginAtlas.plist" />
          </TextureFrame>
          <TextureFrame FrameIndex="35" Tween="False">
            <TextureFile Type="MarkedSubImage" Path="LoadEffects/008.png" Plist="LoginAtlas.plist" />
          </TextureFrame>
          <TextureFrame FrameIndex="40" Tween="False">
            <TextureFile Type="MarkedSubImage" Path="LoadEffects/009.png" Plist="LoginAtlas.plist" />
          </TextureFrame>
          <TextureFrame FrameIndex="45" Tween="False">
            <TextureFile Type="MarkedSubImage" Path="LoadEffects/010.png" Plist="LoginAtlas.plist" />
          </TextureFrame>
        </Timeline>
      </Animation>
      <ObjectData Name="Node" Tag="15" ctype="GameNodeObjectData">
        <Size X="0.0000" Y="0.0000" />
        <Children>
          <AbstractNodeData Name="background" ActionTag="997126602" Tag="282" IconVisible="False" LeftMargin="-469.0000" RightMargin="-469.0000" TopMargin="-67.5000" BottomMargin="32.5000" Scale9Enable="True" LeftEage="6" RightEage="6" TopEage="6" BottomEage="6" Scale9OriginX="6" Scale9OriginY="6" Scale9Width="926" Scale9Height="23" ctype="ImageViewObjectData">
            <Size X="938.0000" Y="35.0000" />
            <Children>
              <AbstractNodeData Name="load" ActionTag="847743525" Tag="3926" IconVisible="False" LeftMargin="-1.0000" RightMargin="1.0000" TopMargin="1.5000" BottomMargin="-1.5000" ProgressInfo="6" ctype="LoadingBarObjectData">
                <Size X="938.0000" Y="35.0000" />
                <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                <Position X="468.0000" Y="16.0000" />
                <Scale ScaleX="1.0000" ScaleY="1.0000" />
                <CColor A="255" R="255" G="255" B="255" />
                <PrePosition X="0.4989" Y="0.4571" />
                <PreSize X="1.0000" Y="1.0000" />
                <ImageFileData Type="MarkedSubImage" Path="logoe/loadingf_01.png" Plist="LoginAtlas.plist" />
              </AbstractNodeData>
              <AbstractNodeData Name="LoadEffects" ActionTag="1873350510" Tag="3929" IconVisible="False" LeftMargin="432.5000" RightMargin="432.5000" TopMargin="-18.5030" BottomMargin="-19.4970" ctype="SpriteObjectData">
                <Size X="73.0000" Y="73.0000" />
                <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                <Position X="469.0000" Y="17.0030" />
                <Scale ScaleX="1.0000" ScaleY="1.0000" />
                <CColor A="255" R="255" G="255" B="255" />
                <PrePosition X="0.5000" Y="0.4858" />
                <PreSize X="0.0778" Y="2.0857" />
                <FileData Type="MarkedSubImage" Path="LoadEffects/010.png" Plist="LoginAtlas.plist" />
                <BlendFunc Src="1" Dst="771" />
              </AbstractNodeData>
              <AbstractNodeData Name="text" ActionTag="1628958158" Tag="3927" IconVisible="False" LeftMargin="59.9998" RightMargin="78.0002" TopMargin="-31.9998" BottomMargin="40.9998" IsCustomSize="True" FontSize="20" LabelText="如花第一季" HorizontalAlignmentType="HT_Center" VerticalAlignmentType="VT_Center" OutlineEnabled="True" ShadowOffsetX="1.0000" ShadowOffsetY="-1.0000" ctype="TextObjectData">
                <Size X="800.0000" Y="26.0000" />
                <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
                <Position X="459.9998" Y="53.9998" />
                <Scale ScaleX="2.0067" ScaleY="2.5488" />
                <CColor A="255" R="255" G="255" B="255" />
                <PrePosition X="0.4904" Y="1.5429" />
                <PreSize X="0.8529" Y="0.7429" />
                <FontResource Type="Normal" Path="" Plist="" />
                <OutlineColor A="255" R="0" G="0" B="0" />
                <ShadowColor A="255" R="0" G="0" B="0" />
              </AbstractNodeData>
            </Children>
            <AnchorPoint ScaleX="0.5000" ScaleY="0.5000" />
            <Position Y="50.0000" />
            <Scale ScaleX="1.0000" ScaleY="1.0000" />
            <CColor A="255" R="255" G="255" B="255" />
            <PrePosition />
            <PreSize X="0.0000" Y="0.0000" />
            <FileData Type="MarkedSubImage" Path="logoe/loading_01.png" Plist="LoginAtlas.plist" />
          </AbstractNodeData>
        </Children>
      </ObjectData>
    </Content>
  </Content>
</GameFile>