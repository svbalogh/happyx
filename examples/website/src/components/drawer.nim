import
  ../../../../src/happyx,
  ../ui/[colors, translations],
  ../components/[button, sidebar]


proc chooseLang*(lang: cstring) =
  languageSettings.set($lang)
  buildJs:
    localStorage["happyx_spoken_language"] = ~lang
  route(currentRoute)

proc toggleDrawer*() =
  let
    drawerBack = document.getElementById("drawerBack")
    drawer = document.getElementById("drawer")
  drawerBack.classList.toggle("opacity-0")
  drawerBack.classList.toggle("opacity-100")
  drawerBack.classList.toggle("pointer-events-none")
  drawer.classList.toggle("translate-x-full")
  drawer.classList.toggle("translate-x-0")
  echo 1


component Drawer:
  isOpen: bool = false

  `template`:
    # Drawer background
    tDiv(id = nu"drawerBack", class = "fixed duration-500 opacity-0 pointer-events-none transition-all w-screen h-screen z-40 bg-[#00000060]"):
      @click:
        toggleDrawer()
    tDiv(id = nu"drawer", class = "fixed right-0 duration-300 transition-all ease-out w-2/3 translate-x-full h-screen z-50 bg-[{BackgroundSecondary}] dark:bg-[{BackgroundSecondaryDark}]"):
      tDiv(class = "w-full h-full flex flex-col gap-8 jusitfy-center items-center py-8 px-8 overflow-y-scroll"):
        tDiv(class = "w-full flex justify-end items-center"):
          Button(
            action = proc() =
              toggleDrawer(),
            flat = true
          ):
            tP(class = "text-4xl"):
              "x"
        Button(
          action = proc() =
            {.emit:"""//js
            window.open('https://github.com/HapticX/happyx', '_blank').focus();
            """.},
          flat = true
        ):
          tDiv(class = "flex items-center gap-4"):
            tSvg(
              width="98", height="96", viewBox = "0 0 98 96", xmlns="http://www.w3.org/2000/svg",
              class = "h-6 w-6 fill-[{Foreground}] dark:fill-[{ForegroundDark}]"
            ):
              tPath(
                d="M48.854 0C21.839 0 0 22 0 49.217c0 21.756 13.993 40.172 33.405 46.69 2.427.49 3.316-1.059 3.316-2.362 0-1.141-.08-5.052-.08-9.127-13.59 2.934-16.42-5.867-16.42-5.867-2.184-5.704-5.42-7.17-5.42-7.17-4.448-3.015.324-3.015.324-3.015 4.934.326 7.523 5.052 7.523 5.052 4.367 7.496 11.404 5.378 14.235 4.074.404-3.178 1.699-5.378 3.074-6.6-10.839-1.141-22.243-5.378-22.243-24.283 0-5.378 1.94-9.778 5.014-13.2-.485-1.222-2.184-6.275.486-13.038 0 0 4.125-1.304 13.426 5.052a46.97 46.97 0 0 1 12.214-1.63c4.125 0 8.33.571 12.213 1.63 9.302-6.356 13.427-5.052 13.427-5.052 2.67 6.763.97 11.816.485 13.038 3.155 3.422 5.015 7.822 5.015 13.2 0 18.905-11.404 23.06-22.324 24.283 1.78 1.548 3.316 4.481 3.316 9.126 0 6.6-.08 11.897-.08 13.526 0 1.304.89 2.853 3.316 2.364 19.412-6.52 33.405-24.935 33.405-46.691C97.707 22 75.788 0 48.854 0z"
              )
            tP: {translate"Source code"}
        Button(
          action = proc() =
            route"/guide/",
          flat = true
        ):
          {translate"📕 Documentation"}
        Button(
          action = proc() =
            route"/sandbox/",
          flat = true
        ):
          {translate"▶ Sandbox"}
        Button(
          action = proc() =
            route"/sponsors/",
          flat = true
        ):
          {translate"🔥 Sponsors"}
        Button(
          action = proc() =
            route"/roadmap/",
          flat = true
        ):
          {translate"🌎 RoadMap"}
        tDiv(class = "flex self-center items-center flex-col gap-4"):
          tP(class = "text-6xl lg:text-3xl"):
            {translate"🌐 Language"}
          tDiv(class = "flex flex-col justify-center items-center gap-4"):
            Button(action = proc() =
              toggleDrawer()
              chooseLang(cstring"en")
            ):
              "English"
            Button(action = proc() =
              toggleDrawer()
              chooseLang(cstring"ru")
            ):
              "Русский"
            Button(action = proc() =
              toggleDrawer()
              chooseLang(cstring"ja")
            ):
              "日本語"
            Button(action = proc() =
              toggleDrawer()
              chooseLang(cstring"zh")
            ):
              "中文"
            Button(action = proc() =
              toggleDrawer()
              chooseLang(cstring"ko")
            ):
              "한국어"
            Button(action = proc() =
              toggleDrawer()
              chooseLang(cstring"fr")
            ):
              "Français"
        tDiv:
          if ($currentRoute).startsWith("/guide/"):
            SideBar(isMobile = true)
