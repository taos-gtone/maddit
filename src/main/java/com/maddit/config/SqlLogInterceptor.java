package com.maddit.config;

import org.apache.ibatis.executor.statement.StatementHandler;
import org.apache.ibatis.mapping.BoundSql;
import org.apache.ibatis.mapping.ParameterMapping;
import org.apache.ibatis.plugin.*;
import org.apache.ibatis.session.ResultHandler;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.sql.Statement;
import java.lang.reflect.Field;
import java.util.List;
import java.util.Properties;

@Intercepts({
    @Signature(type = StatementHandler.class, method = "query",  args = {Statement.class, ResultHandler.class}),
    @Signature(type = StatementHandler.class, method = "update", args = {Statement.class})
})
public class SqlLogInterceptor implements Interceptor {

    private static final Logger log = LoggerFactory.getLogger("SQL");

    @Override
    public Object intercept(Invocation invocation) throws Throwable {
        StatementHandler handler = (StatementHandler) invocation.getTarget();
        BoundSql boundSql = handler.getBoundSql();

        String sql = boundSql.getSql();
        Object param = boundSql.getParameterObject();
        List<ParameterMapping> paramMappings = boundSql.getParameterMappings();

        // SQL 포맷팅: 줄바꿈 정리
        String formatted = formatSql(sql);

        // 파라미터 정보
        StringBuilder paramStr = new StringBuilder();
        if (paramMappings != null && !paramMappings.isEmpty()) {
            for (ParameterMapping pm : paramMappings) {
                String propName = pm.getProperty();
                Object value = getParamValue(param, propName);
                if (paramStr.length() > 0) paramStr.append(", ");
                paramStr.append(propName).append("=").append(value);
            }
        }

        long start = System.currentTimeMillis();
        try {
            Object result = invocation.proceed();
            long elapsed = System.currentTimeMillis() - start;
            log.debug("\n┌─── SQL ──────────────────────────────────\n{}\n├─── Params: {}\n└─── {}ms", formatted, paramStr, elapsed);
            return result;
        } catch (Exception e) {
            long elapsed = System.currentTimeMillis() - start;
            log.error("\n┌─── SQL (ERROR) ──────────────────────────\n{}\n├─── Params: {}\n├─── {}ms\n└─── {}", formatted, paramStr, elapsed, e.getMessage());
            throw e;
        }
    }

    private String formatSql(String sql) {
        // 여러 공백/줄바꿈을 단일 공백으로 변환 후 키워드 앞에서 줄바꿈
        String s = sql.replaceAll("\\s+", " ").trim();
        s = s.replaceAll("(?i)\\b(SELECT|FROM|LEFT JOIN|INNER JOIN|JOIN|WHERE|AND|OR|ORDER BY|GROUP BY|HAVING|LIMIT|OFFSET|INSERT INTO|VALUES|UPDATE|SET|DELETE FROM)\\b", "\n  $1");
        // 첫 줄 앞 줄바꿈 제거
        if (s.startsWith("\n")) s = s.substring(1);
        return s;
    }

    private Object getParamValue(Object param, String propName) {
        if (param == null) return "null";
        if (param instanceof java.util.Map) {
            return ((java.util.Map<?, ?>) param).get(propName);
        }
        // 단일 파라미터
        if (param instanceof String || param instanceof Number || param instanceof Boolean) {
            return param;
        }
        // 리플렉션으로 필드 조회
        try {
            Field field = param.getClass().getDeclaredField(propName);
            field.setAccessible(true);
            return field.get(param);
        } catch (Exception e) {
            return param.toString();
        }
    }

    @Override
    public Object plugin(Object target) {
        return Plugin.wrap(target, this);
    }

    @Override
    public void setProperties(Properties properties) {
    }
}
