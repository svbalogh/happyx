import
  happyx,
  ../ui/colors


component Card:
  id: cstring

  `template`:
    tDiv(
      id = "{self.id}",
      class = "flex will-change-transform justify-center items-center gap-12 w-fit drop-shadow-2xl rounded-md bg-[{Background}] dark:bg-[{BackgroundDark}] text-3xl md:text-2xl lg:text-xl xl:text-base pr-4"
    ):
      slot
