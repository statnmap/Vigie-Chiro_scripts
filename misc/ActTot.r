library(data.table)
SED="./Tadarida/Vigie-Chiro_scripts/Vigie-Chiro_scripts/SelExportDonnees.r"
EPD="./Tadarida/Vigie-Chiro_scripts/Vigie-Chiro_scripts/extr_PF_DataLP.r"
EPA="./Tadarida/Vigie-Chiro_scripts/Vigie-Chiro_scripts/extr_PF_ActNuit.r"

PP=c("55","56","57","58","59","5a","5b","5c","5d")

#PP=c("5b")


args="Valid"
args[3]="90"
args[10]="D:/VigieChiro/Raw"
args[12]=""
args[13]=""
args[14]=""


source(SED) #to save validated data

for (i in 1:length(PP))
{
  print(paste(i,Sys.time()))
  args[1]="PrefPart"
  
  for (j in c(c(0:9),"a","b","c","d","e","f"))
  {
    args[2]=paste0(PP[i],j)
    print(args[2])
    Sys.time()
    source(SED) 
    Sys.time()
      args[11]=paste0(args[10],"/export_",args[2],".csv")
      testsize=file.size(args[11])
      if(testsize>200)
      {
        
      source(EPD) # 3e5 donnees/min
      Sys.time()
        args[4]=paste0(args[10],"/DataLP_PF_export_",args[2],".csv")
        if(file.exists(args[4]))
        {
          
          source(EPA) # 1e6 donnees/min
        Sys.time()
      }
    }
  }
}

Pattern=basename(paste0(args[10],"/SpNuit2_",args[3],"_DataLP_PF_export_"))

SpToAgg=list.files(args[10],pattern=Pattern,full.names=T)

my.data=list()
for (k in 1:length(SpToAgg))
{
  my.data[[k]]=fread(SpToAgg[k])
}
ActTot=rbindlist(my.data)
fwrite(ActTot,paste0(args[10],"/SpNuit2_",args[3],"_DataLP_PF_exportTot.csv"))
