with comments as (
    select *
    from {{ source('so','comment_events') }}
)
select
    DATE_TRUNC('month',create_ts) AS month,
    COUNT(distinct user_id) AS active_users,
    COUNT(distinct post_id) AS posts_count
FROM comments
GROUP BY 1