package com.sky.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.conditions.update.LambdaUpdateWrapper;
import com.sky.context.UserHolder;
import com.sky.entity.AddressBook;
import com.sky.mapper.AddressBookMapper;
import com.sky.service.AddressBookService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
public class AddressBookServiceImpl implements AddressBookService {

    @Autowired
    private AddressBookMapper addressBookMapper;

    @Override
    public List<AddressBook> findList() {
        LambdaQueryWrapper<AddressBook> wrapper = new LambdaQueryWrapper<>();
        wrapper.eq(AddressBook::getUserId, UserHolder.get());
        return addressBookMapper.selectList(wrapper);
    }

    @Override
    public void save(AddressBook addressBook) {
        //补齐参数
        addressBook.setIsDefault(0);//非默认地址
        addressBook.setUserId(UserHolder.get());

        //保存
        addressBookMapper.insert(addressBook);
    }

    @Override
    @Transactional
    public void setdefault(AddressBook addressBook) {
        LambdaUpdateWrapper<AddressBook> lambdaUpdateWrapper = new LambdaUpdateWrapper();
        lambdaUpdateWrapper.eq(AddressBook::getUserId,UserHolder.get());
        AddressBook addressBook1 = new AddressBook();
        addressBook1.setIsDefault(0);
        addressBookMapper.update(addressBook1,lambdaUpdateWrapper);
        addressBook.setIsDefault(1);
        addressBookMapper.updateById(addressBook);
    }

    @Override
    public AddressBook getdefault() {
        LambdaQueryWrapper<AddressBook> addressBookLambdaQueryWrapper = new LambdaQueryWrapper<>();
        addressBookLambdaQueryWrapper.eq(AddressBook::getUserId,UserHolder.get()).eq(AddressBook::getIsDefault,1);


        return addressBookMapper.selectOne(addressBookLambdaQueryWrapper);
    }

    @Override
    public AddressBook findbyid(long id) {
        AddressBook addressBook = addressBookMapper.selectById(id);
        return addressBook;
    }

    @Override
    public void updatebyid(AddressBook addressBook) {
        addressBookMapper.updateById(addressBook);
    }

    @Override
    public void delect(Long id) {
        addressBookMapper.deleteById(id);
    }
}
