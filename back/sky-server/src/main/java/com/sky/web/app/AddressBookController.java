package com.sky.web.app;

import com.sky.entity.AddressBook;
import com.sky.result.Result;
import com.sky.service.AddressBookService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/user/addressBook")
public class AddressBookController {

    @Autowired
    private AddressBookService addressBookService;

    //查询当前登录用户的地址列表
    @GetMapping("/list")
    public Result findList() {
        List<AddressBook> addressBookList = addressBookService.findList();
        return Result.success(addressBookList);
    }

    //保存
    @PostMapping
    public Result save(@RequestBody AddressBook addressBook){
        addressBookService.save(addressBook);
        return Result.success();
    }
    @PutMapping("/default")
    public  Result setdefault(@RequestBody AddressBook addressBook){
        addressBookService.setdefault(addressBook);
                return Result.success();

    }
    @GetMapping("/default")
    public Result getdefault(){
        AddressBook getdefault = addressBookService.getdefault();
        return Result.success(getdefault);
    }
    @GetMapping("/{id}")
    public  Result getaddress(@PathVariable long id){
        AddressBook findbyid = addressBookService.findbyid(id);
        return  Result.success(findbyid);

    }
    @PutMapping()
    public  Result update(@RequestBody AddressBook addressBook){
        addressBookService.updatebyid(addressBook);
        return  Result.success();

    }
    @DeleteMapping()
    public  Result delect(Long id){
        addressBookService.delect(id);
        return Result.success();
    }


}
