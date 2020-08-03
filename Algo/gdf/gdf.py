import pandas as pd
# input_dir    = './logs/' # The input directory
output_dir   = './gdf_result/' # The result directory
#log_filepath = input_dir + 'Apache/Apache_2k.log_structured.csv'
ḍf2=pd.read_csv('Apache_2k.log_structured.csv')
#n=df2.values
col=df2.columns
gdf=pd.DataFrame(columns=col)
df1=pd.read_csv('HDFS_2k.log_structured.csv')
gdfc=df1.columns
gdf['Level']=df2['Level']
gdf['Content']=df1['Content']
gdf['EventTemplate']=df1['EventTemplate']
gdf['Time']=df2['Time']
gdf['LineId']=df2['LineId']
gdf['EventId']=df1['EventId']
gdf.to_csv(output_dir+'/gdf.csv')