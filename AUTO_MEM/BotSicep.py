import time
from selenium import webdriver
from selenium.webdriver.common.by import By
from selenium.webdriver.support.ui import WebDriverWait
from selenium.webdriver.support import expected_conditions as EC
import pandas as pd


#Abre el navegador y descarga el excel

options = webdriver.ChromeOptions()
prefs = {"download.default_directory":r"C:\Users\alfam\OneDrive\Documentos\Trabajito\WEB"}  #ruta de descarga del excel esto se cuadrara en el futuro
options.add_experimental_option("prefs", prefs)
driver = webdriver.Chrome(options=options)
driver.get("https://sicep.xm.com.co/public-announcements")
time.sleep(2)

excel = driver.find_element(By.ID,'btnexportexcel')
excel.click()
time.sleep(8)


#Filtra los datos

data = pd.read_excel("ConvocatoriasPublicas.xlsx")
data=data.drop(["ExclusivaFNCER","FechaSuspension","FechaReactivacion","FechaCancelacion","FechaCierreConvocatoria"],axis=1)
data = data.query('Estado == "Cerrada y adjudicada"')
data['FechaLimiteRecepcionOfertas'] = pd.to_datetime(data['FechaLimiteRecepcionOfertas'],format='%d/%m/%Y')

fecha_inicio = '01/01/2024'
fecha_inicio = pd.to_datetime(fecha_inicio, format='%d/%m/%Y')
data = data[data['FechaLimiteRecepcionOfertas'] >= fecha_inicio]
listaCodigos= data['CodigoConvocatoria'].tolist()
#print(listaCodigos)

#empieza a iterar por cada codigo de convocatoria

dataframes = []
for codigo in listaCodigos:
  driver.get("https://sicep.xm.com.co/public-announcements")
  BarraBusqueda = driver.find_element(By.CLASS_NAME, "inputCodAnnouncement")
  BarraBusqueda.clear()
  BarraBusqueda.send_keys(codigo)
  time.sleep(1)

  Bbusqueda = driver.find_element(By.ID,'btoshearch')
  Bbusqueda.click()

  time.sleep(2)
  BotonConvo = driver.find_element(By.ID, "colvaluever")
  BotonConvo.click()
  time.sleep(3)

  Menu = driver.find_element(By.ID, "expediente")
  MenuDesple = Menu.find_elements(By.TAG_NAME, "p-accordiontab")
  
  menufechas = MenuDesple[1]
  menufechas.click()
  time.sleep(2) 
  SecFechas = driver.find_elements(By.CSS_SELECTOR,'div.ui-g-12.ui-g-nopad-l > p')
  FechaOferta = SecFechas[1].text
  FechaAudencia = SecFechas[2].text
  PrecioReserva = 0
  
  MenuConvo = MenuDesple[0] 
  MenuConvo.click()
  time.sleep(2)
  comprador = driver.find_element(By.CSS_SELECTOR, 'p.h6light')
  comprador = comprador.text

  

  div_productos = driver.find_elements(By.CLASS_NAME,"ui-g-3.detcolumnProd.clickbutton.ng-star-inserted")
  time.sleep(1)
  ProductosExcel = pd.DataFrame()
  
  #itera por cada producto de la convocatoria

  Productos = []
  for producto in div_productos:

    InfoProductos = []
    elemento_a = producto.find_element(By.TAG_NAME,"a")
    CodigoProducto = elemento_a.text
    print(CodigoProducto)
    elemento_a.click()
    time.sleep(4) 
    MenuProducto = driver.find_element(By.CLASS_NAME, "ng-trigger-animation")
    Textos = MenuProducto.find_elements(By.TAG_NAME,"P")
    FechaInicio= Textos[len(Textos)-5].text
    FechaFinal= Textos[len(Textos)-3].text

    #los organiza en un dataframe

    InfoProductos.append(codigo)
    InfoProductos.append(comprador)
    InfoProductos.append(CodigoProducto)
    InfoProductos.append(FechaInicio)
    InfoProductos.append(FechaFinal)
    InfoProductos.append(FechaOferta)
    InfoProductos.append(FechaAudencia)
    InfoProductos.append(PrecioReserva)
    Productos.append(InfoProductos)
    

    elemento_div = driver.find_element(By.XPATH, "//div[contains(@class, 'ui-dialog-titlebar-icons')]")  
    BotonCerrar = elemento_div.find_element(By.TAG_NAME,"a")
    BotonCerrar.click()
    #time.sleep(2)
 

  columnas = ['Convocatoria','Comprador', 'Producto', 'FechaInicio','FechaFinal','FechaOfertas','FechaAudencia','PrecioReserva']
  InfoAños= pd.DataFrame(Productos,columns=columnas)
  #print(InfoAños)

  #Extrae el precio promedio adjudicado de cada producto

  MenuConvo = MenuDesple[6]
  MenuConvo.click()
  time.sleep(2)

  Tabla = driver.find_element(By.TAG_NAME,"p-table")
  Filas = Tabla.find_elements(By.TAG_NAME,'tr')
  Precios=[]
  for fila in Filas:
    preciosprod=[]
    dato = fila.find_elements(By.TAG_NAME, "td")
    info=[]
    for i in dato:
      info.append(i.text)
    Precios.append(info)  

  columnas1 = ['Producto','Energia_Demandada','Energia_Adjudicada','Precio_Promedio_adjudicado']
  InfoPrecios= pd.DataFrame(Precios,columns=columnas1)
  #print(InfoPrecios)
  InfoPrecios = InfoPrecios.drop(InfoPrecios.index[0])
  ProductosDefinitivo = pd.merge(InfoAños,InfoPrecios,left_on=['Producto'],right_on=['Producto'],how='left')

  ProductosDefinitivo.replace('', pd.NA, inplace=True)
  ProductosDefinitivo = ProductosDefinitivo.dropna()

  ProductosDefinitivo['Energia_Demandada'] = pd.to_numeric(ProductosDefinitivo['Energia_Demandada'], errors='coerce')
  ProductosDefinitivo['Energia_Adjudicada'] = pd.to_numeric(ProductosDefinitivo['Energia_Adjudicada'], errors='coerce')
  ProductosDefinitivo['Precio_Promedio_adjudicado'] = pd.to_numeric(ProductosDefinitivo['Precio_Promedio_adjudicado'], errors='coerce')
  # = pd.concat([df_2020,ProductosDefinitivo], ignore_index=True)
  print(ProductosDefinitivo)
  dataframes.append(ProductosDefinitivo)
  time.sleep(2)


#crea un excel con todos los productos

ProductosExcel = pd.concat(dataframes, ignore_index=True)  
ProductosExcel.to_excel('ProductosDefinitivos2.xlsx')



