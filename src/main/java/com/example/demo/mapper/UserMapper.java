package com.example.demo.mapper;

import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;

import com.example.demo.controller.User;

import java.util.List;
import java.util.Optional;

@Mapper
public interface UserMapper {
    
    @Select("SELECT * FROM users WHERE username = #{username}")
    Optional<User> findByUsername(String username);

    @Insert("INSERT INTO users (username, \"password\", \"role\", created_at) VALUES (#{username}, #{password}, #{role}, NOW())")
    void save(User user);

    @Select("SELECT * FROM users")
    List<User> findAll();
}