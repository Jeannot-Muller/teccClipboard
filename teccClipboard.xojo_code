#tag Class
Protected Class teccClipboard
Inherits WebSDKUIControl
	#tag Event
		Sub DrawControlInLayoutEditor(g as graphics)
		  // Visual WebSDK controls can "draw" themselves in the IDE
		  
		  '// todo4
		  g.FontName = "Helvetica"
		  g.FontUnit = FontUnits.Point
		  g.FontSize = 40
		  
		  
		  If BooleanProperty("enabled") = False Then
		    g.Transparency = 60
		  Else
		    g.Transparency = 0
		  End If
		  
		  g.FontSize = 30
		  g.DrawingColor = ColorProperty( "InActiveColor" ) 
		  g.DrawText( "c", 11, 25)
		  g.FontSize = 40
		  g.DrawingColor = ColorProperty( "ActiveColor" ) 
		  g.DrawText( "C", 4, 32)
		  g.DrawingColor = ColorProperty( "HoverColor" ) 
		  g.FillOval( 0, 0, 10, 10)
		End Sub
	#tag EndEvent

	#tag Event
		Function ExecuteEvent(name as string, parameters as JSONItem) As Boolean
		  // Events sent with TriggerServerEvent using your controlID will end up here
		  Try
		    Select Case Name
		    Case "teccClipboardClick"
		      
		      Try
		        If parameters.value("target") = "i" Then
		          If AutoDisableButton Then
		            value = ""
		          end if
		          teccClipboardClick()
		          Return True
		        End If 
		      Catch err As OutOfBoundsException
		        
		      End Try
		    End Select
		    
		  Catch
		    
		  End Try
		End Function
	#tag EndEvent

	#tag Event
		Function HandleRequest(Request As WebRequest, Response As WebResponse) As Boolean
		  #Pragma unused Request
		  #Pragma unused Response
		  // Requests sent to the session with the following pattern
		  // 
		  // /<Session Identifier>/sdk/<controlID>/request_path
		  
		End Function
	#tag EndEvent

	#tag Event
		Function JavaScriptClassName() As String
		  // Name of your JavaScript class which extends XojoWeb.XojoVisualControl
		  Return "tecc.teccClipboard"
		End Function
	#tag EndEvent

	#tag Event
		Sub Opening()
		  
		  
		  
		  
		  
		  
		  
		End Sub
	#tag EndEvent

	#tag Event
		Sub Serialize(js as JSONItem)
		  // Use this method to serialize the data your control needs for initial setup
		  js.value("value") = value
		  js.value("activeColor") = "#" + ActiveColor.toString.Right(6)
		  js.value("inactiveColor") = "#" + InactiveColor.toString.Right(6)
		  js.value("hoverColor") = "#" + HoverColor.toString.Right(6)
		  js.value("autoDisableButton") = AutoDisableButton
		  js.value("enabled") = Me.enabled
		  js.value("faIcon") = Me.FontawesomeIcon
		  
		  
		  
		  
		  
		End Sub
	#tag EndEvent

	#tag Event
		Function SessionCSSURLs(session as WebSession) As String()
		  #Pragma unused Session
		  // Return an array of CSS URLs for your control
		  // Here's one way to do this...
		  
		  If teccClipboardCSS = Nil Then
		    Var cssStr As String
		    Var css() As String
		    
		    css.Add(":root {")
		    css.Add("--teccClipboardColor: #" + InactiveColor.ToString.Right(6) + ";")
		    css.Add("--teccClipboardHover: #" + InactiveColor.ToString.Right(6) + ";")
		    css.Add("}")
		    
		    css.Add(".teccClipboardBtn {")
		    css.Add("background-Color: transparent;")
		    css.Add("border: none;")
		    css.Add("Color: var(--teccClipboardColor);")
		    css.Add("display: inline-block;")
		    css.Add("Font-size: 20px;")
		    css.Add("}")
		    css.Add(".teccClipboardBtn:hover {")
		    css.Add("Color: var(--teccClipboardHover);")
		    css.Add("}")
		    css.Add(".teccClipboard {")
		    css.Add("display: inline-box;")
		    css.Add("cursor: pointer;")
		    css.Add("outline: none;}")
		    css.Add("box-shadow: none;}")
		    css.Add("}")
		    
		    cssStr = String.FromArray( css, "" )
		    
		    teccClipboardCSS = New WebFile
		    teccClipboardCSS.Filename = "teccClipboard.css"
		    teccClipboardCSS.MIMEType = "text/css"
		    teccClipboardCSS.data = cssStr
		    teccClipboardCSS.Session = Nil 
		  End If
		  
		  Var urls() As String
		  urls.Add( teccClipboardCSS.URL )
		  
		  Return urls
		End Function
	#tag EndEvent

	#tag Event
		Function SessionHead(session as WebSession) As String
		  #Pragma unused session
		  // Return anything that you needed added to the <head> of the web app
		  
		  Var fontA As String = "<link rel='stylesheet' href='https://pro.fontawesome.com/releases/v5.13.0/css/all.css'>"
		  
		  Return fontA
		End Function
	#tag EndEvent

	#tag Event
		Function SessionJavascriptURLs(session as WebSession) As String()
		  #Pragma unused session
		  If JSFramework = Nil Then
		    JSFramework = New WebFile
		    JSFramework.Filename = "teccClipboard.js"
		    JSFramework.MIMEType ="text/javascript"
		    JSFramework.data = kJSCode
		    JSFramework.Session = Nil 
		  End If
		  
		  Dim urls() As String
		  urls.Add( JSFramework.URL )
		  
		  Return urls
		End Function
	#tag EndEvent


	#tag Hook, Flags = &h0, Description = 4669726573207768656E2074686520636F6E74726F6C20697320636C69636B65642E2052657475726E7320746865206368616E676564207374617475732E0A737461747573203D2074686520737461747573206F662074686520636F6E74726F6C2E0A6F626A6563746964203D20746865206964206F6620746865206372656174656420444F4D20656C656D656E742E
		Event teccClipboardClick()
	#tag EndHook


	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return mactiveColor
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  mactiveColor = value
			  updateControl
			End Set
		#tag EndSetter
		ActiveColor As color
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return mAutoDisableButton
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  mAutoDisableButton = value
			  UpdateControl
			End Set
		#tag EndSetter
		AutoDisableButton As Boolean
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return mFontawesomeIcon
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  mFontawesomeIcon = value
			  UpdateControl
			  
			End Set
		#tag EndSetter
		FontawesomeIcon As string
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return mHoverColor
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  mHoverColor = value
			  UpdateControl
			End Set
		#tag EndSetter
		HoverColor As Color
	#tag EndComputedProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return mInactiveColor
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  mInactiveColor = value
			  UpdateControl
			End Set
		#tag EndSetter
		InactiveColor As Color
	#tag EndComputedProperty

	#tag Property, Flags = &h21
		Private Shared JSFramework As WebFile
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mactiveColor As color = &c0000ff
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mAutoDisableButton As Boolean = False
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mAutoDisableIfEmpty As boolean = false
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mFontawesomeIcon As string = "fa fa-paste"
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mHoverColor As Color = &c008f51
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mInactiveColor As Color = &c797979
	#tag EndProperty

	#tag Property, Flags = &h21
		Private mTransparentBackground As boolean
	#tag EndProperty

	#tag Property, Flags = &h21
		#tag Note
			mValue = value
		#tag EndNote
		Private mvalue As string
	#tag EndProperty

	#tag Property, Flags = &h21
		Private Shared teccClipboardCSS As WebFile
	#tag EndProperty

	#tag ComputedProperty, Flags = &h0
		#tag Getter
			Get
			  Return mvalue
			End Get
		#tag EndGetter
		#tag Setter
			Set
			  mvalue = value
			  UpdateControl
			  
			End Set
		#tag EndSetter
		value As string
	#tag EndComputedProperty


	#tag Constant, Name = kJSCode, Type = String, Dynamic = False, Default = \"\"use strict\";\nvar tecc;\n(function (tecc) {\n    class teccClipboard extends XojoWeb.XojoVisualControl {\n        constructor(id\x2C events) {\n            super(id\x2C events);\n        }\n        render() {\n            super.render();\n            let el \x3D this.DOMElement();\n            if (!el)\n                return;\n            this.setAttributes(el);\n            var idstr \x3D el.id + \"_teccClipboard\";\n            let btn \x3D document.createElement(\"div\");\n            let styleStr \x3D \"\";\n            let hoverColor \x3D \"\";\n            let disabledStr \x3D \"\";\n            let visibilityStr \x3D \' visibility: visible;\'\n            if (this.autoDisableButton \x3D\x3D true && this.value \x3D\x3D \"\") {\n              visibilityStr \x3D \' visibility: hidden;\';\n            }\n            if (this.value \x3D\x3D \"\") {\n                disabledStr \x3D \" disabled\";\n                styleStr \x3D \" --teccClipboardColor: \" + this.inactiveColor + \"\';\";\n                hoverColor \x3D \'--teccClipboardHover: \' + this.inactiveColor;\n            } else {\n                disabledStr \x3D \"\";\n                styleStr \x3D \" --teccClipboardColor: \" + this.activeColor +  \"\';\";\n               hoverColor \x3D \'--teccClipboardHover: \' + this.hoverColor;\n            }\n            var opacityStr \x3D \"\";\n            if (!this.enabled) {\n                disabledStr \x3D \" disabled\";\n                opacityStr \x3D \";opacity: 40%;cursor: not-allowed !important\";\n                styleStr \x3D \" --teccClipboardColor: \" + this.inactiveColor + \"\';\"; \n                hoverColor \x3D \' --teccClipboardHover: \' + this.inactiveColor;            \n            }\n            var cbid \x3D \"ts\" + idstr;\n            var iChecked \x3D \"\"; \n            btn.innerHTML \x3D \"<button class\x3D\'teccClipboardBtn\'\" + disabledStr + \" style\x3D\'\" + visibilityStr + styleStr + opacityStr + \"\'><i class\x3D\'\" + this.faIcon + \"\'></i></button>\";\n            btn.id \x3D idstr;\n            btn.myValue \x3D this.value;\n            if (this.value !\x3D\x3D \"\") {\n            btn.addEventListener(\"click\"\x2C function (event) {\n                copyToClipboard( event.currentTarget.myValue );\n                var controlObject \x3D XojoWeb.getNamedControl(el.id);\n                var jsonObj \x3D new XojoWeb.JSONItem();\n                jsonObj.set(\'ID\'\x2C el.id);\n                jsonObj.set(\'target\'\x2C event.target.tagName);\n                jsonObj.set(\'myvalue\'\x2C this.value);\n                controlObject.triggerServerEvent(\'teccClipboardClick\'\x2C jsonObj)\x2C true;\n            });\n            }\n            btn.style.cssText\x3DhoverColor;\n            this.replaceEveryChild(btn);\n            this.applyTooltip(el);\n            this.applyUserStyle(el);\n        }\n        updateControl(data) {\n            super.updateControl(data);\n            let js \x3D $.parseJSON(data);\n            this.refresh();\n            this.value \x3D js.value;\n            this.enabled \x3D js.enabled;\n            this.activeColor \x3D js.activeColor;\n            this.inactiveColor \x3D js.inactiveColor;\n            this.hoverColor \x3D js.hoverColor;   \n            this.faIcon \x3D js.faIcon;  \n            this.autoDisableButton \x3D js.autoDisableButton;\n        }\n    }\nfunction copyToClipboard (myText) {\n navigator.clipboard.writeText( myText);\n}\ntecc.teccClipboard \x3D teccClipboard;\n})(tecc || (tecc \x3D {}));\n\n", Scope = Private
	#tag EndConstant

	#tag Constant, Name = LibraryIcon, Type = String, Dynamic = False, Default = \"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\x3D\x3D", Scope = Public
	#tag EndConstant

	#tag Constant, Name = NavigatorIcon, Type = String, Dynamic = False, Default = \"iVBORw0KGgoAAAANSUhEUgAAABAAAAAQCAYAAAAf8/9hAAABe2lDQ1BJQ0MgUHJvZmlsZQAAKJF9kE0rRFEYx3/Gy4jRLFhQFjdvqyFGiY2amYSaxTRGedvcueZFzYzbnStkY6FsFSU23hZ8AjYWylopRUp2vgCxka7nGBov5annPL/znOf8O+cPLp9umpmyTsjmbCs6GNTGxic09wMVeKmkkQbdyJuBSCSMxFf9GS/XlKh61a60/p7/G9XTibwBJZXC/YZp2cJDws3ztqlY6dVZ8ijhZcWpAm8ojhf46GMmFg0JnwprRlqfFr4T9hlpKwsupd8S/zaT+sbZzJzx+R71E08iNzoitUmykTxRBgmiMcwAIXrook/WHtrx0yE77MSCrS6HZs1FayaVtrWAOJHQhnNGh0/zd/plRvn6269ib3YXep+hdK3Yi2/CySrU3xZ7LTvgXYHjc1O39I9WqaQrmYTHQ6gZh9pLqJrMJ7v9hR95glB+7zhPreBeh7c1x3ndc5y3fbksHp3lCh59anFwA7ElCF/A1ja0ibZ36h38D2cZEcQ8aAAAAGxlWElmTU0AKgAAAAgABAEaAAUAAAABAAAAPgEbAAUAAAABAAAARgEoAAMAAAABAAIAAIdpAAQAAAABAAAATgAAAAAAAABgAAAAAQAAAGAAAAABAAKgAgAEAAAAAQAAABCgAwAEAAAAAQAAABAAAAAAyJjDqAAAAAlwSFlzAAAOxAAADsQBlSsOGwAAAWJJREFUOBFjYMANIoBS94H4DRDX////nx2IDYFYDlkLM5QjC6QDgNgQiA2A2BKIZwHxByB+BsTRX79+zX/+/HnexYsXC1VVVQ1PnTp19d+/f6+AcgycQPwSiP9jwXEGBgbGWMRBan8BsQYQM8gDMTbNILH3jIyMIBfgkndgAUqig7tAgS8wQWFhYUEZGRkw9+/fvwxXrlxhAIYDTBpMywNJZBsEkWWBipWB+CcQg4G8vDyyWqwu6AMa8BFmCNALDEFBQbfl5OS0gYHG8OoVONxg0mAa3QXINhBiOzChGAXkJCQk2ACjSQTIBHkFGbeiqwXxMQJRX1//iKmp6fMpU6b0XL9+/R2SJl0kNgqTIi9guGDdunUMQkJCYBsuX748Izc3dyWSdYxA9mogFoaJYRjAz8/PICAgAJYXFxf/CWSAkjMMgAz4C+PAaIq8AIqFPzCTyKVBzloPxITiHF3+MlCPMACoRbbsmDaxlgAAAABJRU5ErkJggg\x3D\x3D", Scope = Public
	#tag EndConstant


	#tag ViewBehavior
		#tag ViewProperty
			Name="Index"
			Visible=true
			Group="ID"
			InitialValue="-2147483648"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Name"
			Visible=true
			Group="ID"
			InitialValue=""
			Type="String"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Super"
			Visible=true
			Group="ID"
			InitialValue=""
			Type="String"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Height"
			Visible=true
			Group="Position"
			InitialValue="34"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Width"
			Visible=true
			Group="Position"
			InitialValue="100"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="LockBottom"
			Visible=true
			Group="Position"
			InitialValue="False"
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="LockHorizontal"
			Visible=true
			Group="Position"
			InitialValue="False"
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="LockLeft"
			Visible=true
			Group="Position"
			InitialValue="True"
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="LockRight"
			Visible=true
			Group="Position"
			InitialValue="False"
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="LockTop"
			Visible=true
			Group="Position"
			InitialValue="True"
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="LockVertical"
			Visible=true
			Group="Position"
			InitialValue="False"
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Left"
			Visible=true
			Group="Position"
			InitialValue="0"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Top"
			Visible=true
			Group="Position"
			InitialValue="0"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Enabled"
			Visible=true
			Group="Appearance"
			InitialValue=""
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Visible"
			Visible=true
			Group="Appearance"
			InitialValue=""
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="value"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="string"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="TabIndex"
			Visible=true
			Group="Visual Controls"
			InitialValue=""
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="FontawesomeIcon"
			Visible=true
			Group="teccClipboard"
			InitialValue="fa fa-paste"
			Type="string"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="ActiveColor"
			Visible=true
			Group="teccClipboard"
			InitialValue="&c008e00"
			Type="color"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="InactiveColor"
			Visible=true
			Group="teccClipboard"
			InitialValue="&c797979"
			Type="Color"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="HoverColor"
			Visible=true
			Group="teccClipboard"
			InitialValue="&c0096ff"
			Type="Color"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="AutoDisableButton"
			Visible=true
			Group="teccClipboard"
			InitialValue="False"
			Type="Boolean"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="_mPanelIndex"
			Visible=false
			Group="Behavior"
			InitialValue="-1"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Indicator"
			Visible=false
			Group="Visual Controls"
			InitialValue=""
			Type="WebUIControl.Indicators"
			EditorType="Enum"
			#tag EnumValues
				"0 - Default"
				"1 - Primary"
				"2 - Secondary"
				"3 - Success"
				"4 - Danger"
				"5 - Warning"
				"6 - Info"
				"7 - Light"
				"8 - Dark"
				"9 - Link"
			#tag EndEnumValues
		#tag EndViewProperty
		#tag ViewProperty
			Name="_mName"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
		#tag ViewProperty
			Name="ControlID"
			Visible=false
			Group="Behavior"
			InitialValue=""
			Type="String"
			EditorType="MultiLineEditor"
		#tag EndViewProperty
	#tag EndViewBehavior
End Class
#tag EndClass
