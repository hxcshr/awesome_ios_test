//
//  RxSwiftViewController.swift
//  GitHub_Pod_Test
//
//  Created by mengkezheng on 2019/3/26.
//  Copyright © 2019 com.qudao. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import Cartography

struct Music {
    let name: String
    let singer: String
    
    init(name: String, singer: String) {
        self.name = name
        self.singer = singer
    }
}

extension Music: CustomStringConvertible {
    var description: String {
        return "name: \(name) singer:\(singer)"
    }
    
}

struct MusicListViewModel {
    let data = Observable.just([
        Music(name: "无条件", singer: "陈奕迅"),
        Music(name: "你曾是少年", singer: "S.H.E"),
        Music(name: "从前的我", singer: "陈洁仪"),
        Music(name: "在木星", singer: "朴树"),
    ])
}

class RxSwiftViewController: UIViewController {

    let tableView = UITableView()
    
    let musicListViewModel = MusicListViewModel()
    
    let disposeBag = DisposeBag()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
//        tableView.dataSource = self;
//        tableView.delegate = self;
        view .addSubview(tableView)
        constrain(view,tableView) { (view,tableView) in
            tableView.edges == view.edges
        }
        
        
        musicListViewModel.data.bind(to: tableView.rx.items(cellIdentifier: "cell")) {_, music, cell in
            cell.textLabel?.text = music.name
            cell.detailTextLabel?.text = music.singer
        }.disposed(by: disposeBag)
        

        tableView.rx.modelSelected(Music.self).subscribe(onNext: { (music) in
            print("\(music)")
        }).disposed(by: disposeBag)
        
        let observable = Observable<String>.create { observer in
            observer.onNext("baidu.com")
            observer.onCompleted()
            return Disposables.create()
        }
        
        observable.subscribe() {
            print($0)
        }
        
        var isOdd = true
        
        let factory: Observable<Int> = Observable.deferred {
            isOdd = !isOdd
            if isOdd {
                return Observable.of(1,3,5,7)
            }else {
                return Observable.of(2,4,6,8)
            }
        }
        
        factory.subscribe { event in
            print("\(isOdd)",event)
        }
        factory.subscribe { event in
            print("\(isOdd)",event)
        }
        
        let scheduler = SerialDispatchQueueScheduler(qos: .default)
        
//        let subscription = Observable<Int>.interval(0.3, scheduler: scheduler).subscribe {
//            event in
//            print(event)
//        }
//
//        Thread.sleep(forTimeInterval: 2.0)
//
//        subscription.dispose()


                let observable1 = Observable.of("A","B","C")
        

        
                let sub = observable1.subscribe {event in
                    if event.isCompleted {
                       print(event)
                    }else {
                        print(event.element ?? "")
                    }
                }
        
                    observable1.do(onNext: { (element) in
                        print("***" + element);
                    }, onError: { (errro) in
                        print(errro)
                    }, onCompleted: {
                        print("completed before")
                    }, onSubscribe: {
                        print("subscribe")
                    }, onSubscribed: {
                        print("subscribed")
                    }) {
                        print("disposed before")
                        }.subscribe(onNext: { (element) in
                            print(element)
                        }, onError: { (error) in
                            print(error)
                        }, onCompleted: {
                            print("completed")
                        }) {
                            print("disposed")
        }

        sub.dispose();


        
        let label = UILabel(frame: CGRect(x: 16, y: 160, width: 160, height: 20));
        self.view.addSubview(label)
        
        let obser2 = Observable<Int>.interval(1, scheduler: MainScheduler.instance)
        
        obser2.map { (index) -> String in
            return "当前索引：\(index)"
            }.bind { (text) in
                label.text = text;
        }.disposed(by: disposeBag)
        
        
        let observer: AnyObserver<String> = AnyObserver { (event) in
            switch event {
            case .next(let data):
                print(data)
            case .error(let error):
                print(error)
            case .completed:
                print("completed")
            }
            
        }
        
        let obser3 = Observable.of("我","的","天")
        obser3.subscribe(observer).disposed(by: disposeBag)
        obser3.bind(to: observer).disposed(by: disposeBag)
        
        
        let binder: Binder<String> = Binder(label) { (view,text) in
            view.text = text
        }
        obser2.map { (i) -> String in
            return "当前索引数：\(i)"
        }.bind(to: label.rx.text)
        .disposed(by: disposeBag)
        
        let obser5 = Observable<Int>.interval(1, scheduler: MainScheduler.instance)
        obser5.map
            { CGFloat($0) }.bind(to: label.rx.fontSize).disposed(by: disposeBag)
        
        
        let subject = PublishSubject<String>()
        
        subject.onNext("111")
        
        subject.subscribe(onNext: { (str) in
            print("第1次订阅：", str)
        },onCompleted: {
            print("第1次订阅：onCompleted")
        }).disposed(by: disposeBag)

        
        subject.onNext("222")
        
        
        let behaviorSubject = BehaviorSubject(value: "qqq")
        behaviorSubject.subscribe { (event) in
            print("第一次订阅:", event)
        }.disposed(by: disposeBag)
        
        behaviorSubject.onNext("www")
        
        behaviorSubject.subscribe { (event) in
            print("第二次订阅:",event)
        }.disposed(by: disposeBag)
        
        let replaySubject = ReplaySubject<String>.create(bufferSize: 2)
        
        replaySubject.onNext("eee")
        replaySubject.onNext("rrr")
        replaySubject.onNext("ttt")
        
        replaySubject.subscribe { (event) in
            print("replay 1:",event)
        }.disposed(by: disposeBag)
        
        replaySubject.onNext("yyy")
        
        replaySubject.subscribe { (event) in
            print("replaySubject 2:",event)
        }.disposed(by: disposeBag)
        
        replaySubject.onCompleted()
        
        replaySubject.subscribe { (event) in
            print("replaySubject 3:",event)
        }.disposed(by: disposeBag)
        
        
        let variable = Variable("uuu")
        variable.value = "iii"
        variable.asObservable().subscribe { (event) in
            print("variable 1：", event)
        }.disposed(by: disposeBag)
        
        variable.value = "ooo"
        
        variable.asObservable().subscribe { (event) in
            print("variable 2: ",event)
        }.disposed(by: disposeBag)
        
        variable.value = "ppp"
        
        
        let publishS = PublishSubject<String>()
        
        publishS.buffer(timeSpan: 1, count: 3, scheduler: MainScheduler.instance)
            .subscribe { (str) in
                print(str)
        }.disposed(by: disposeBag)
        
        
        publishS.window(timeSpan: 1, count: 3, scheduler: MainScheduler.instance)
            .subscribe(onNext: { [weak self] (eee) in
                eee.asObservable().subscribe(onNext: {print($0)}).disposed(by: self!.disposeBag)
            }).disposed(by: disposeBag)
        
        publishS.onNext("a")
        publishS.onNext("b")
        publishS.onNext("d")
        
        publishS.onNext("1")
        publishS.onNext("2")
        publishS.onNext("3")

        Observable.of(1,2,3)
            .map({$0 * 10}).subscribe(onNext: {print($0)}).disposed(by: disposeBag)
        
        let b1 = BehaviorSubject(value: "A")
        let b2 = BehaviorSubject(value: "1")
        
        let var1 = Variable(b1)
        
        var1.asObservable()
            .flatMap { $0 }
            .subscribe(onNext: { print($0) } )
        .disposed(by: disposeBag)
        
        
        b1.onNext("B")
        var1.value = b2
        b2.onNext("2")
        b1.onNext("C")
        
        Observable.of(2,30,22,5,60,3,40,9)
            .filter {
                $0 > 10
        }.subscribe(onNext: {print($0)})
        .disposed(by: disposeBag)
        
        Observable.of(1,2,3,4)
            .single{ $0 == 2 }
        .subscribe(onNext: { print($0) })
        .disposed(by: disposeBag)
        
        Observable.of("A","B","C","D")
        .single()
        .subscribe(onNext: { print($0) })
        .disposed(by: disposeBag)
        
        Observable.of(1,2,3,4).ignoreElements()
            .subscribe {
                print($0)
        }.disposed(by: disposeBag)
        
        Observable.of(1,2,3,4)
        .take(2)
        .subscribe(onNext: {print($0)})
        .disposed(by: disposeBag)
        
        let s1 = PublishSubject<Int>()
        let s2 = PublishSubject<Int>()
        
        s1.withLatestFrom(s2)
        .subscribe(onNext: { print($0) })
        .disposed(by: disposeBag)
        
        s1.toArray().subscribe(onNext: { print($0) } )
        .disposed(by: disposeBag)
        
        s1.onNext(1)
        s2.onNext(11)
        s1.onNext(2)
        s1.onNext(3)
        s2.onNext(22)
        s1.onNext(4)
        
//        let ob1 = Observable.of(1,2,3)
//        .toArray().subscribe(onNext: {print($0)})
//        .disposed(by: disposeBag)
        

        
    }
    

}

extension Reactive where Base: UILabel {
    public var fontSize: Binder<CGFloat> {
        return Binder(self.base) { label, fontSize in
            label.font = UIFont.systemFont(ofSize: fontSize)
        }
    }
}

//extension UILabel {
//    public var fontSize: Binder<CGFloat> {
//        return Binder(self, binding: { (label, fontSize) in
//            label.font = UIFont.systemFont(ofSize: fontSize)
//        })
//    }
//}

//extension RxSwiftViewController: UITableViewDataSource {
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return musicListViewModel.data.count
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView .dequeueReusableCell(withIdentifier: "cell", for: indexPath)
//        let music = musicListViewModel.data[indexPath.row]
//        cell.textLabel?.text = music.name
//        cell.detailTextLabel?.text = music.singer
//        return cell;
//    }
//}
//
//extension RxSwiftViewController: UITableViewDelegate {
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        print("你选中的歌曲信息【\(musicListViewModel.data[indexPath.row])】")
//    }
//}
