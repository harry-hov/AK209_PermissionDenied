import pandas as pd
output_dir   = './gdf_result' # The result directory
output_dir   = './logs/' # The input
serverlog='Apache/Apache_2k.log_structured.csv'
df2=pd.read_csv(output_dir+serverlog)
col=df2.columns
gdf=pd.DataFrame(columns=col)
df1=pd.read_csv('./logs/HDFS/HDFS_2k.log_structured.csv')
gdfc=df1.columns
gdf['Level']=df2['Level']
gdf['Content']=df1['Content']
gdf['EventTemplate']=df1['EventTemplate']
gdf['Time']=df2['Time']
gdf['LineId']=df2['LineId']
gdf['EventId']=df1['EventId']
gdf.to_csv(output_dir+'/gdf.csv')