-- LLVMXcode.applescript
-- LLVMXcode

--  Created by Norberto Ortigoza on 02/08/08.
--  Copyright 2008 CrossHorizons. All rights reserved.
on plugin loaded theBundle
	
	script padre
		on choose menu item theObject
			set supportpath to ((path to application support from user domain) as text)
			set newFile to (supportpath & "LLVMXcodePlugin:configuration.txt")
			
			tell application "System Events"
				set ignoreexist to (exists file newFile)
			end tell
			
			if (not ignoreexist) then
				tell application "Finder"
					make new folder at supportpath with properties {name:"LLVMXcodePlugin"}
					set fparchivo to open for access newFile with write permission
					write " " to fparchivo
					close access fparchivo
				end tell
			end if
			
			set fparchivo to open for access newFile with write permission
			
			try
				set contenido to read fparchivo
				set scanbuildoptions to (text returned of (display dialog "Introduce some value" default answer contenido))
				set eof fparchivo to 0
				write scanbuildoptions to fparchivo
				close access fparchivo
			on error
				close access fparchivo
			end try
			
		end choose menu item
	end script
	
	script pluginScript
		property scanbuildoptions : "-V"
		--property xcodebuildoptions : "-configuration Debug"
		
		on choose menu item theObject
			set menutitle to (title of theObject)
			
			tell application "Xcode"
				set existopendocuments to (count of (project documents))
				if existopendocuments > 0 then
					set projectpath to (project directory of (project of active project document))
					set activetarget to (name of (active build configuration type of (project of active project document)))
					
					if (title of theObject = "Clean,Build & Analyze") then
						try
							clean (project of active project document)
						on error
							--display dialog "ok"
						end try
					end if
				else
					display dialog "There is not open project..." & return & "Please open an existing project o create a new one." buttons {"Accept"}
					return
				end if
			end tell
			
			set supportpath to ((path to application support from user domain) as text)
			set newFile to (supportpath & "LLVMXcodePlugin:configuration.txt")
			tell application "System Events"
				set ignoreexist to (exists file newFile)
			end tell
			
			if (not ignoreexist) then
				tell application "Finder"
					make new folder at supportpath with properties {name:"LLVMXcodePlugin"}
					set fparchivo to open for access newFile with write permission
					write "-configuration Debug" to fparchivo
					close access fparchivo
				end tell
			end if
			
			set fparchivo to open for access newFile
			try
				set xcodebuildoptions to read fparchivo
			on error
				close access fparchivo
			end try
			close access fparchivo
			
			set scanCommand to ("clear; cd '" & projectpath & "'; scan-build " & scanbuildoptions & " xcodebuild " & "-configuration " & activetarget & " " & xcodebuildoptions)
			
			tell application "Terminal" --TODO I need to validate if there is not an open window
				tell its front window
					set mytab to (selected tab)
				end tell
				do script scanCommand in mytab
			end tell
			
		end choose menu item
	end script
	
	--	set pluginMenu to the first menu of main menu whose title is "Build"
	set pluginMenu to make new menu at end of menus of main menu with properties {title:"LLVM", name:"analyzer"}
	set cleanItem to make new menu item at beginning of menu items of pluginMenu with properties {title:"Clean,Build & Analyze", name:"clean"}
	set analyzeItem to make new menu item at beginning of menu items of pluginMenu with properties {title:"Build & Analyze", name:"static analizer"}
	set configItem to make new menu item at beginning of menu items of pluginMenu with properties {title:"XcodeBuild Parameters", name:"config"}
	set script of analyzeItem to pluginScript
	set script of configItem to padre
	set script of cleanItem to pluginScript
	
end plugin loaded
