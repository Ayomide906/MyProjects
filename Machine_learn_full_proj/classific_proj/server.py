from fastapi import FastAPI,UploadFile,File,HTTPException
from fastapi.responses import StreamingResponse
import pandas as pd
import io
from classify import classify_csv

app=FastAPI()
@app.post('/read_csv')
async def read_csv(file:UploadFile=File(...)):
    content =await file.read()
    df=pd.read_csv(io.StringIO(content.decode('utf-8')))
    df_out=classify_csv(df)
    buffer=io.StringIO()
    df_out.to_csv(buffer,index=False)
    buffer.seek(0)
    return StreamingResponse(
        iter([buffer.getvalue()]),
        media_type='text/csv',
        headers={'Content-Disposition':'attachment; filename=classified_logs.csv'}
    )



