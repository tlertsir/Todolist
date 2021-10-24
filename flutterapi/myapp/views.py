from django.shortcuts import render
from django.http import JsonResponse

from rest_framework.response import Response
from rest_framework.decorators import api_view
from rest_framework import status
from .serializers import TodolistSerializer
from .models import Todolist

# GET Data
@api_view(['GET'])
def all_todolist(request):
    alltodolist = Todolist.objects.all()
    serializer = TodolistSerializer(alltodolist,many=True)
    return Response(serializer.data, status=status.HTTP_200_OK)


@api_view(['POST'])
def post_todolist(request):
    if request.method == 'POST':
        serializer = TodolistSerializer(data=request.data)
        if serializer.is_valid():
            serializer.save()
            return Response(serializer.data,status=status.HTTP_201_CREATED)
        return Response(serializer.errors,status=status.HTTP_404_NOT_FOUND)


@api_view(['PUT'])
def update_todolist(request,TID):
    todo = Todolist.objects.get(id=TID)

    if request.method == 'PUT':
        data = {}
        serializer = TodolistSerializer(todo,data=request.data)
        if serializer.is_valid():
            serializer.save()
            data['status'] = 'updated'
            return Response(data=data, status=status.HTTP_201_CREATED)
        return Response(serializer.errors, status=status.HTTP_404_NOT_FOUND)

@api_view(['DELETE'])
def delete_todolist(request,TID):
    todo = Todolist.objects.get(id=TID)

    if request.method == 'DELETE':
        delete = todo.delete()
        data = {}
        if delete:
            data['status'] = 'deleted'
            statuscode = status.HTTP_200_OK
        else:
            data['status'] = 'failed'
            statuscode = status.HTTP_400_BAD_REQUEST
        return Response(data=data, status=statuscode)

data = [
    {
        "title": "laptop คืออะไร",
        "subtitle": "laptop คืออุปกรณ์คำนวณ json",
        "img_url": "https://raw.githubusercontent.com/tlertsir/BasicAPI/main/computer.jpg",
        "detail":"detail json คอมพิวเตอร์คืออะไร"
    },
    {
        "title": "มาเขียนโปรแกรมกัน",
        "subtitle": "ฝึกๆๆๆๆ json",
        "img_url": "https://raw.githubusercontent.com/tlertsir/BasicAPI/main/coding.jpg",
        "detail":"detail json มาเขียนโปรแกรมกัน"
    },
    {
        "title": "python คือ",
        "subtitle": "อันที่ 44444444 json",
        "img_url": "https://raw.githubusercontent.com/tlertsir/BasicAPI/main/python.jpg",
        "detail":"detail json python คือ"
    }
]

def Home(request):
    return JsonResponse(data=data,safe=False,json_dumps_params={'ensure_ascii': False})