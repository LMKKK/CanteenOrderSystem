package com.sky.service;

import com.sky.entity.AddressBook;

import java.util.List;

public interface AddressBookService {

    //查询当前登录用户的地址列表
    List<AddressBook> findList();

    //保存
    void save(AddressBook addressBook);

    void setdefault(AddressBook addressBook);

    AddressBook getdefault();

    AddressBook findbyid(long id);

    void updatebyid(AddressBook addressBook);

    void delect(Long id);
}
