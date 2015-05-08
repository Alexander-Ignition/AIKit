//
//  AIHTTPSessionManager.h
//  AIKit
//
//  Created by Alexander Ignition on 21.04.15.
//  Copyright (c) 2015 Alexander Ignition. All rights reserved.
//

#import <AFNetworking/AFHTTPSessionManager.h>

@class AIMantleResponseSerializer;

typedef void (^AIHTTPSuccessBlock)(NSURLSessionDataTask *task, id model);
typedef void (^AIHTTPFailureBlock)(NSURLSessionDataTask *task, NSError *error);
typedef void (^AIHTTPSuccessArrayBlock)(NSURLSessionDataTask *task, NSArray *models);

typedef NS_ENUM(NSUInteger, AIHTTPMethod) {
    AIHTTPMethodGET,
    AIHTTPMethodPOST,
    AIHTTPMethodPUT,
    AIHTTPMethodPATCH,
    AIHTTPMethodDELETE
};

@interface AIHTTPSessionManager : AFHTTPSessionManager

/*!
 @brief Серилизатор ответа сервера в объекты MTLModel
 */
@property (nonatomic, strong, readonly) AIMantleResponseSerializer *mantleResponseSerializer;

/*!
 @brief   Запрос на сервер
          Обертка над методами AFHTTPSessionManager
 @param   method     HTTP метод
 @param   URLString  Относитьный или абсолютный путь
 @param   parameters NSDictionary (id выбран для соответсвия сигнатуре методов AFHTTPSessionManager) 
                     Может принимать nil. Вставка параметров зависит от method
                     AIHTTPMethodGET  -> parameters -> URLString
                     AIHTTPMethodPOST -> parameters -> body
 @param   success    Блок успешности запроса и парсингв данных
 @param   failure    Блок с ошибкой запроса или парсинга данных
 @return  NSURLSessionDataTask
 */
- (NSURLSessionDataTask *)method:(AIHTTPMethod)method
                       URLString:(NSString *)URLString
                      parameters:(id)parameters
                         success:(AIHTTPSuccessBlock)success
                         failure:(AIHTTPFailureBlock)failure;

/*!
 @brief   Запрос на сервер
          Обертка над -method:URLString:parameters:success:failure:
          Парсит в объект класса modelOfClass
 @param   method        HTTP метод
 @param   URLString     Относитьный или абсолютный путь
 @param   parameters    NSDictionary (id выбран для соответсвия сигнатуре методов AFHTTPSessionManager)
                        Может принимать nil. Вставка параметров зависит от method
                        AIHTTPMethodGET  -> parameters -> URLString
                        AIHTTPMethodPOST -> parameters -> body
 @param   modelOfClass  Класс для парсинга. Наследник MTLModel
 @param   key           Ключ по которому в JSON лежит объект для парсинга. 
                        Может принимать nil, тогда будет парситься весь JSON.
 @param   success       Блок успешности запроса и парсингв данных
 @param   failure       Блок с ошибкой запроса или парсинга данных
 @return  NSURLSessionDataTask
 */
- (NSURLSessionDataTask *)method:(AIHTTPMethod)method
                       URLString:(NSString *)URLString
                      parameters:(id)parameters
                    modelOfClass:(Class)modelClass
                          forKey:(NSString *)key
                         success:(AIHTTPSuccessBlock)success
                         failure:(AIHTTPFailureBlock)failure;

/*!
 @brief   Запрос на сервер
          Обертка над -method:URLString:parameters:success:failure:
          Парсит в МАССИВ объект класса modelOfClass
 @param   method        HTTP метод
 @param   URLString     Относитьный или абсолютный путь
 @param   parameters    NSDictionary (id выбран для соответсвия сигнатуре методов AFHTTPSessionManager)
                        Может принимать nil. Вставка параметров зависит от method
                        AIHTTPMethodGET  -> parameters -> URLString
                        AIHTTPMethodPOST -> parameters -> body
 @param   modelOfClass  Класс для парсинга. Наследник MTLModel
 @param   key           Ключ по которому в JSON лежит объект для парсинга.
                        Может принимать nil, тогда будет парситься весь JSON.
 @param   success       Блок успешности запроса и парсингв данных
 @param   failure       Блок с ошибкой запроса или парсинга данных
 @return  NSURLSessionDataTask
 */
- (NSURLSessionDataTask *)method:(AIHTTPMethod)method
                       URLString:(NSString *)URLString
                      parameters:(id)parameters
                   modelsOfClass:(Class)modelClass
                          forKey:(NSString *)key
                         success:(AIHTTPSuccessArrayBlock)success
                         failure:(AIHTTPFailureBlock)failure;
@end

